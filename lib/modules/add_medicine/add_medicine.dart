import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:pharmacy_wiki/modules/home/home.dart';
import 'package:pharmacy_wiki/modules/leaflet/medicine_leaflet.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';
import 'package:pharmacy_wiki/shared/classes/scheduled_medicine.dart';
import 'package:pharmacy_wiki/shared/data/connection.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class Schedule {
  late String time;
  late int weekDay;

  Schedule(this.time, this.weekDay);
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}

class AddMedicine extends StatefulWidget {
  final Medicamento _selectedMedicine;
  const AddMedicine(this._selectedMedicine, {Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState(_selectedMedicine);
}

class _AddMedicineState extends State<AddMedicine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Medicamento _selectedMedicine;
  _AddMedicineState(this._selectedMedicine);

  List<String> _types = ['Frequente', "Único"];
  String _typeValue = 'Frequente';
  List<String> _dosageType = ['Comprimido', "ml"];
  String _dosageTypeValue = 'Comprimido';
  TextEditingController _quantity = new TextEditingController();
  String _reactionValue = 'Sem reação';
  List<String> _reactions = [
    'Sem reação',
    'Sonolência',
    'Ingestão de Alcool',
    'Enjoo'
  ];

  ScrollController _scrollController = new ScrollController();

  Map<String, int> reaction = {
    'Sem reação': 0,
    'Sonolência': 1,
    'Ingestão de Alcool': 2,
    'Enjoo': 3
  };

  Map<int, String> week = {
    DateTime.monday: 'Segunda-Feira',
    DateTime.tuesday: 'Terça-Feira',
    DateTime.wednesday: 'Quarta-Feira',
    DateTime.thursday: 'Quinta-Feira',
    DateTime.friday: 'Sexta-Feira',
    DateTime.saturday: 'Sabado',
    DateTime.sunday: 'Domingo'
  };

  List<Schedule> scheduleList = [new Schedule('12:00', DateTime.now().weekday)];

  void addToSchedule() {
    List<String> hourMinute;
    List<List<String>> schedules = [[], [], [], [], [], [], []];
    String uniqueSchedule = '';

    print(scheduleList.length);

    this.scheduleList.forEach((sch) {
      hourMinute = sch.time.split(':');
      if (hourMinute.length == 2) {
        int? newHour = int.tryParse(hourMinute[0]);
        int? newMinute = int.tryParse(hourMinute[1]);

        if (newHour != null && newMinute != null) {
          int validHour = newHour;
          int validMinute = newMinute;

          var today = DateTime.now();
          var dateSchedule = DateTime(
                  today.year, today.month, today.day, validHour, validMinute, 0)
              .next(sch.weekDay);

          if (this._typeValue == 'Frequente') {
            schedules[sch.weekDay - 1].add(dateSchedule.toIso8601String());
          } else {
            uniqueSchedule = dateSchedule.toIso8601String();
          }
        }

        int? validQuantity = int.tryParse(this._quantity.value.text);

        if (validQuantity != null) {
          ScheduledMedicine scheduledMedicine = new ScheduledMedicine(
              id: null,
              name: this._selectedMedicine.name,
              quantity: validQuantity,
              type: this._dosageTypeValue,
              frequency: new Frequency(
                  isRoutine: this._typeValue == 'Único' ? false : true,
                  schedule: schedules,
                  noRoutine: uniqueSchedule),
              reason: reaction[_reactionValue]);

          Connection conn = new Connection();
          conn.insertMedicine(scheduledMedicine);

          print('ok');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        }
      }
    });
  }

  Widget botaoAdd(String rec) {
    if (rec == 'Único') {
      return SizedBox(
        height: 50,
      );
    }
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
            child: SizedBox(
              width: 180,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.add_alert),
                  Text(
                    "Adicionar Horário",
                    style: AppTextStyles.buttonText,
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                this.scheduleList.add(new Schedule('', DateTime.now().weekday));
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              });
            },
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: new AppBar(
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Column(children: [
                    SizedBox(height: 20),
                    Text('Adicionar Medicamento',
                        style: AppTextStyles.interRegularTitle),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF4F4F4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              this._selectedMedicine.name,
                              style: AppTextStyles.interText,
                            ),
                            TextButton.icon(
                              icon: Icon(Icons.find_in_page,
                                  color: AppColors.primary),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicineLeaflet(
                                          '${_selectedMedicine.name}',
                                          '${_selectedMedicine.bula}',
                                          '${_selectedMedicine.indicacoes}',
                                          '${_selectedMedicine.contraindicacoes}',
                                          '${_selectedMedicine.posologia}')),
                                )
                              },
                              label: Text("Ler bula"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ]),
                ), // HEADER
                Container(
                  height: MediaQuery.of(context).size.height - 350,
                  width: MediaQuery.of(context).size.width - 20,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    reverse: true,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tipo',
                              style: AppTextStyles.interBoldLabel,
                            )),
                        DropdownButtonFormField<String>(
                          value: _typeValue,
                          items: _types
                              .map(
                                  (String dropType) => DropdownMenuItem<String>(
                                        value: dropType,
                                        child: Text(dropType),
                                      ))
                              .toList(),
                          hint: Text('Selecione o tipo...'),
                          onChanged: (newItemsname) {
                            if (newItemsname != null)
                              setState(() {
                                _typeValue = newItemsname;
                                if (newItemsname == 'Único' &&
                                    this.scheduleList.length > 1) {
                                  this
                                      .scheduleList
                                      .removeRange(1, this.scheduleList.length);
                                }
                              });
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) *
                                        0.6,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Dosagem',
                                      style: AppTextStyles.interBoldLabel,
                                    )),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.6,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    value: _dosageTypeValue,
                                    items: _dosageType
                                        .map((String dropDosagem) =>
                                            DropdownMenuItem<String>(
                                              value: dropDosagem,
                                              child: Text(dropDosagem),
                                            ))
                                        .toList(),
                                    hint: Text('Selecione a dosagem...'),
                                    onChanged: (newItemsname) {
                                      if (newItemsname != null)
                                        _dosageTypeValue = newItemsname;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width - 20) *
                                  0.05,
                            ),
                            Column(
                              children: [
                                Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) *
                                        0.35,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Quantidade',
                                      style: AppTextStyles.interBoldLabel,
                                    )),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 20) *
                                          0.35,
                                  height: 50,
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: _quantity,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintStyle: AppTextStyles.placeholder,
                                        hintText: '20'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: (MediaQuery.of(context).size.width - 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Reações',
                              style: AppTextStyles.interBoldLabel,
                            )),
                        Container(
                          width: (MediaQuery.of(context).size.width - 20),
                          height: 50,
                          child: DropdownButtonFormField<String>(
                            value: _reactionValue,
                            items: _reactions
                                .map((String dropReaction) =>
                                    DropdownMenuItem<String>(
                                      value: dropReaction,
                                      child: Text(dropReaction),
                                    ))
                                .toList(),
                            onChanged: (newItemsname) {
                              if (newItemsname != null)
                                _reactionValue = newItemsname;
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Agendamento',
                              style: AppTextStyles.interBoldLabel,
                            )),
                        Column(
                            children: scheduleList
                                .mapIndexed((index, sch) => Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.5,
                                              height: 50,
                                              child:
                                                  DropdownButtonFormField<int>(
                                                value: this
                                                    .scheduleList[index]
                                                    .weekDay,
                                                items: week.values
                                                    .mapIndexed((key, value) =>
                                                        DropdownMenuItem<int>(
                                                          value: this
                                                              .week
                                                              .keys
                                                              .toList()[key],
                                                          child: Text(value),
                                                        ))
                                                    .toList(),
                                                onChanged: (newValue) {
                                                  if (newValue != null)
                                                    this
                                                        .scheduleList[index]
                                                        .weekDay = newValue;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.05,
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.3,
                                              height: 50,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                onChanged: (value) => {
                                                  this
                                                      .scheduleList[index]
                                                      .time = value
                                                },
                                                decoration: InputDecoration(
                                                    hintText: '12:00',
                                                    helperStyle: AppTextStyles
                                                        .placeholder),
                                              ),
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.05,
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20) *
                                                  0.1,
                                              height: 50,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete_forever_sharp,
                                                  color: AppColors.deleteIcon,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (this
                                                            .scheduleList
                                                            .length >
                                                        1) {
                                                      this
                                                          .scheduleList
                                                          .removeAt(index);
                                                    }
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ))
                                .toList()),
                        botaoAdd(this._typeValue),
                      ],
                    ),
                  ),
                ), // CONTENT
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Adicionar Horário",
                            style: AppTextStyles.bigButtonText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed: addToSchedule,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

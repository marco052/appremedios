import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pharmacy_wiki/modules/add_medicine/add_medicine.dart';
import 'package:pharmacy_wiki/modules/medicines/medicamentos_page.dart';
import 'package:pharmacy_wiki/shared/classes/horarioMedicamentos.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';
import 'package:pharmacy_wiki/shared/classes/scheduled_medicine.dart';
import 'package:pharmacy_wiki/shared/classes/user.dart';
import 'package:pharmacy_wiki/shared/data/connection.dart';
import 'package:pharmacy_wiki/shared/services/local_notification.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:pharmacy_wiki/shared/services/medicine.dart' as medicineService;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime hoje = DateTime.now();
  String userName = '';
  List<ScheduledMedicine> medicines = [];
  List<AlarmeMed> alarmes = [];
  List<int> notificationsId = [];

  Future<void> navigationPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MedicamentosPage()));
  }

  Medicamento? getElementByName(String name) {
    for (int i = 0; i < remedios.length; i++) {
      if (remedios[i].name == name) {
        return remedios[i];
      }
    }
    return null;
  }

  List<Medicamento> remedios = [];

  void loadList() async {
    var medicineList = await medicineService.listAll();
    for (int i = 0; i < medicineList.length; i++) {
      var aux = new Medicamento.contrutor(medicineList[i]['id'],
          medicineList[i]['alias'], medicineList[i]['description']);
      aux.indicacoes = medicineList[i]['indications'];
      aux.contraindicacoes = medicineList[i]['contraindications'];
      aux.posologia = medicineList[i]['posology'];
      remedios.add(aux);
    }
  }

  String convertTime(DateTime time) {
    String dia = "0" + time.day.toString();
    dia = dia.substring(dia.length - 2);

    String mes = 'Janeiro';

    switch (time.month) {
      case 1:
        mes = 'Janeiro';
        break;
      case 2:
        mes = 'Fevereiro';
        break;
      case 3:
        mes = 'Mar??o';
        break;
      case 4:
        mes = 'Abril';
        break;
      case 5:
        mes = 'Maio';
        break;
      case 6:
        mes = 'Junho';
        break;
      case 7:
        mes = 'Julho';
        break;
      case 8:
        mes = 'Agosto';
        break;
      case 9:
        mes = 'Setembro';
        break;
      case 10:
        mes = 'Outubro';
        break;
      case 11:
        mes = 'Novembro';
        break;
      case 12:
        mes = 'Dezembro';
        break;
    }

    String ano = "000" + time.year.toString();
    ano = ano.substring(ano.length - 4);

    return "Dia $dia de $mes, $ano";
  }

  Future<void> onInit() async {
    loadList();
    updateSchedule();
  }

  void addDay() {
    setState(() {
      this.hoje = this.hoje.add(Duration(days: 1));
    });
    updateSchedule();
  }

  void backDay() {
    setState(() {
      this.hoje = this.hoje.add(Duration(days: -1));
    });
    updateSchedule();
  }

  void programNotifications() {
    LocalNotification().cancelAllNotifications();
    for (var i in medicines) {
      if (i.frequency.isRoutine) {
        var medicinesToday = i.frequency.schedule[DateTime.now().weekday-1];
        
        for(var m in medicinesToday){
          var hour1 = DateTime.parse(m);
          if(hour1.isAfter(DateTime.now())){
            LocalNotification().displayScheduledNotification(
              "Hora do ${i.name}!",
              "Lembre-se de tomar ${i.quantity} ${i.type} do rem??dio!",
              hour1, 
            );
          }
        }  
      } else {
        print("foi n??o boy");
        var hour1 = DateTime.parse(i.frequency.noRoutine);
        var today = DateTime.now();
        if(hour1.isAfter(today) && hour1.day == today.day && hour1.month == today.month && hour1.year == today.year){
          LocalNotification().displayScheduledNotification(
            "Hora do ${i.name}!",
              "Lembre-se de tomar ${i.quantity} ${i.type} do rem??dio!",
              hour1, 
          );
        }
      }
    }
  }


  void updateSchedule() async {
    Connection conn = Connection();
    List<User> userInfo = await conn.getUserInfo();
    setState(() {
      this.userName = userInfo[0].value.split(' ')[0];
    });
    medicines = await conn.getMedicines();
    print(medicines);

    List<AlarmeMed> alarmsToAdd = [];

    for (ScheduledMedicine medicine in medicines) {
      if (medicine.frequency.isRoutine) {
        for (String hour in medicine.frequency.schedule[hoje.weekday - 1]) {
          DateTime time = DateTime.parse(hour);
          String hr = "0" + time.hour.toString();
          hr = hr.substring(hr.length - 2);
          String min = "0" + time.minute.toString();
          min = min.substring(min.length - 2);

          alarmsToAdd.add(new AlarmeMed.construtor(
              medicine.id!,
              medicine.name,
              'Utilizar ${medicine.quantity} ${medicine.type}',
              '$hr:$min',
              (medicine.reason != null && medicine.reason! > 0)));
        }
      } else {
        DateTime time = DateTime.parse(medicine.frequency.noRoutine);

        if (time.day == hoje.day &&
            time.month == hoje.month &&
            time.year == hoje.year) {
          String hr = "0" + time.hour.toString();
          hr = hr.substring(hr.length - 2);
          String min = "0" + time.minute.toString();
          min = min.substring(min.length - 2);

          alarmsToAdd.add(new AlarmeMed.construtor(
              medicine.id!,
              medicine.name,
              'Utilizar ${medicine.quantity} ${medicine.type}',
              '$hr:$min',
              (medicine.reason != null && medicine.reason! > 0)));
        }
      }
    }

    programNotifications();

    setState(() {
      alarmes = alarmsToAdd;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => onInit());
    programNotifications();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Ol??, $userName",
          style: AppTextStyles.interBoldTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: AppColors.text, size: 30),
                    onPressed: backDay,
                  ),
                  Text(
                    convertTime(hoje),
                    style: AppTextStyles.interBoldText,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.text,
                      size: 30,
                    ),
                    onPressed: addDay,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 260,
              child: ListView.builder(
                itemCount: alarmes.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        title: Text(
                          alarmes[index].medicamento,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          alarmes[index].descricao,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        dense: true,
                        trailing: SizedBox(
                          width: 70,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              alarmes[index].hasRestriction
                                  ? Flexible(
                                      child: Icon(
                                        Icons.warning,
                                        size: 15,
                                        color: AppColors.warning,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 15,
                                    ),
                              Flexible(
                                child: Icon(
                                  Icons.alarm,
                                  size: 15,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              Text(
                                alarmes[index].horario,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.placeholder,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddMedicine(
                                          getElementByName(
                                              alarmes[index].medicamento)!,
                                          id: alarmes[index].id)));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: Text(
                  "Medicamentos",
                  style: AppTextStyles.buttonText,
                ),
                onPressed: () {
                  /*LocalNotification().displayScheduledNotification(
                      'Oi', 'Luscas', DateTime.now().add(Duration(minutes: 1)));*/
                  programNotifications();
                  navigationPage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

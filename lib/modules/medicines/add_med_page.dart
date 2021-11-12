import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class AddPg extends StatefulWidget {
  const AddPg({Key? key}) : super(key: key);

  @override
  _AddPgState createState() => _AddPgState();
}

class _AddPgState extends State<AddPg> {
  String dropdownvalue = '';
  var _diapadrao = 'SEGUNDA-FEIRA';
  var _dias = [
    'SEGUNDA-FEIRA',
    'TERÇA-FEIRA',
    'QUARTA-FEIRA',
    'QUINTA-FEIRA',
    'SEXTA-FEIRA',
    'SÁBADO',
    'DOMINGO'
  ];

  var _currentItemSelected = 'Único';
  var _items = ['Único', 'Agendado'];

  String dosagelvalue = '';
  var _dosagemItem = 'Comprimido';
  var _dosagem = ['Comprimido', 'ML'];
  String qtdHint = "1";

  Widget botaoAdd(String rec) {
    if (rec == 'Único') {
      return SizedBox();
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
              child: Row(
                children: [
                  Icon(Icons.access_alarm),
                  Text(
                    "Adicionar Horário",
                    style: AppTextStyles.buttonText,
                  ),
                ],
              ),
            ),
            onPressed: () {},
          )),
    );
  }

  Row horarioUnico(String rec) {
    if (rec == 'Único') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 115,
              child: DropdownButton<String>(
                items: _dias.map((String dropDias) {
                  return DropdownMenuItem<String>(
                    value: dropDias,
                    child: Text(dropDias),
                  );
                }).toList(),
                onChanged: (newDias) {
                  setState(() {
                    this._diapadrao = newDias!;
                  });
                },
                value: _diapadrao,
              )),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[400], height: 1),
                  hintText: '12:00'),
            ),
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
            width: MediaQuery.of(context).size.width - 120,
            child: DropdownButton<String>(
              items: _dias.map((String dropDias) {
                return DropdownMenuItem<String>(
                  value: dropDias,
                  child: Text(dropDias),
                );
              }).toList(),
              onChanged: (newDias) {
                setState(() {
                  this._diapadrao = newDias!;
                });
              },
              value: _diapadrao,
            )),
        SizedBox(
          width: 15,
        ),
        SizedBox(
          width: 40,
          child: TextField(
            autofocus: false,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400], height: 1),
                hintText: '12:00'),
          ),
        ),
        SizedBox(
            child: IconButton(
          icon: Icon(Icons.delete_forever_sharp, color: Colors.red),
          onPressed: () {},
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.background,
          child: () {
            return Column(mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Text('Adicionar Medicamento',
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontStyle: FontStyle.normal,
                        fontSize: 36.0,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Remédio X',
                            style: TextStyle(
                                fontFamily: "Jost",
                                fontSize: 26,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 180,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.find_in_page,
                              color: Colors.blue[400],
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    height: 80,
                    width: 380,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 380,
                    child: Text('Tipo',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: DropdownButton<String>(
                      hint: Text('tipo de dosagem'),
                      items: _items.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (newItemsname) {
                        setState(() {
                          this._currentItemSelected = newItemsname!;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Text('Dosagem',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width - 115,
                          child: DropdownButton<String>(
                            items: _dosagem.map((String dropDosagem) {
                              return DropdownMenuItem<String>(
                                value: dropDosagem,
                                child: Text(dropDosagem),
                              );
                            }).toList(),
                            onChanged: (newDosagem) {
                              setState(() {
                                this._dosagemItem = newDosagem!;
                                switch (_dosagemItem) {
                                  case 'Comprimido':
                                    this.qtdHint = "1";
                                    break;
                                  default:
                                    this.qtdHint = "20";
                                    break;
                                }
                              });
                            },
                            value: _dosagemItem,
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              alignLabelWithHint: false,
                              hintStyle:
                                  TextStyle(color: Colors.grey[400], height: 1),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Jost',
                                fontStyle: FontStyle.normal,
                              ),
                              labelText: "Quantidade",
                              hintText: qtdHint),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  horarioUnico(_currentItemSelected),
                  SizedBox(
                    height: 30,
                  ),
                  botaoAdd(_currentItemSelected)
                ]);
          }()),
    ));
  }
}

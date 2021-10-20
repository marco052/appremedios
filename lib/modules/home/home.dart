import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pharmacy_wiki/modules/medicines/medicamentos_page.dart';
import 'package:pharmacy_wiki/shared/classes/horarioMedicamentos.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AlarmeMed> alarmes = [
    new AlarmeMed.construtor("rivotril", "Aplicar na veia 100ml", "12h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h"),
    new AlarmeMed.construtor("paracetamol", "Cheirar 50g em pó", "14h")
  ];

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MedicamentosPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Olá, Marquinho",
          style: AppTextStyles.interBoldTitle,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 600,
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
                        width: 40,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                      onTap: () {},
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
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
                navigationPage();
              },
            ),
          )
        ],
      ),
    );
  }
}

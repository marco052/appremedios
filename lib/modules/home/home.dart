import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pharmacy_wiki/modules/medicines/medicamentos_page.dart';
import 'package:pharmacy_wiki/shared/classes/horarioMedicamentos.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';
import 'package:pharmacy_wiki/shared/classes/user.dart';
import 'package:pharmacy_wiki/shared/data/connection.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime hoje = DateTime.now();
  String userName = '';

  List<AlarmeMed> alarmes = [
    new AlarmeMed.construtor("paracetamol", "Utilizar 1 comprimido", "14:00"),
  ];

  Future<void> navigationPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MedicamentosPage()));
  }

  String convertTime(DateTime time) {
    String dia = "0" + time.day.toString();
    dia = dia.substring(dia.length - 2);

    String mes = 'Janeiro';

    switch(time.month) {
      case 1:
        mes = 'Janeiro';
        break;
      case 2:
        mes = 'Fevereiro';
        break;
      case 3:
        mes = 'Março';
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
    Connection conn = Connection();
    List<User> userInfo = await conn.getUserInfo();
    setState((){ 
      this.userName = userInfo[0].value.split(' ')[0];
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => onInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Olá, $userName",
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
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.text, size: 30),
                    onPressed: () => { setState((){ this.hoje = this.hoje.add(Duration(days: -1)); }) },
                  ),
                  Text(
                    convertTime(hoje),
                    style: AppTextStyles.interBoldText,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: AppColors.text, size: 30,),
                    onPressed: () => { setState((){ this.hoje = this.hoje.add(Duration(days: 1)); }) },
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
                          width: 55,
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
      ),
    );
  }
}

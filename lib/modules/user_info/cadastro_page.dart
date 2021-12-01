import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_wiki/modules/home/home.dart';
import 'package:pharmacy_wiki/shared/classes/user.dart';
import 'package:pharmacy_wiki/shared/data/connection.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_images.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class CadastroPage extends StatefulWidget {
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}


class _CadastroPageState extends State<CadastroPage> {
  bool value = false;
  int val = -1;
  List<User> userInfo = [];
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();
  final sexController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  Future<void> navigationPage() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  Future<void> onInit() async {
    Connection conn = Connection();
    userInfo = await conn.getUserInfo();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => onInit());
  }

  void saveUserInfo() async {
    Connection conn = Connection();
    
    for (var i = 0; i < userInfo.length; i++) {
      String type = userInfo[0].alias;
      String value = "";

      switch (type) {
        case 'NAME':
          value = nameController.text;
          break;
        case 'BIRTHDAY':
          value = birthdayController.text;
          break;
        case 'SEX':
          break;
        case 'HEIGHT':
          value = heightController.text;
          break;
        case 'WEIGHT':
          value = weightController.text;
          break;
        default:
          break;
      }
      
      User updated = User(
        id: userInfo[0].id,
        alias: userInfo[0].alias,
        value: value
      );

      conn.updateUserInfo(updated);
    }

    navigationPage();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "PharmacyWiki",
        theme: ThemeData(primaryColor: Colors.blue[200]),
        home: Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.background,
                  child: () {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text("Podemos te conhecer melhor?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Antonio",
                                fontSize: 37,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 25,
                        ),
                        (Image.asset(AppImages.doctors)),
                        Row(children: <Widget>[
                          SizedBox(width: 50),
                          SizedBox(
                              width: 280,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                controller: nameController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal),
                                  labelText: 'Nome',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                  hintText: 'Marquinho Antoninho',
                                ),
                              )),
                        ]),
                        Row(children: <Widget>[
                          SizedBox(width: 50),
                          SizedBox(
                              width: 160,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                controller: birthdayController,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal),
                                  labelText: 'Data de nascimento',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                  hintText: '01/10/2021',
                                ),
                              )),
                          SizedBox(
                            width: 30,
                            child: Icon(Icons.male),
                          ),
                          Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 1;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                          SizedBox(
                            width: 30,
                            child: Icon(Icons.female),
                          ),
                          Radio(
                            value: 2,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = 2;
                              });
                            },
                            activeColor: Colors.black,
                          )
                        ]),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            SizedBox(
                                width: 130,
                                child: TextFormField(
                                  autofocus: false,
                                  textAlign: TextAlign.left,
                                  controller: heightController,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                      fontWeight: FontWeight.normal),
                                    labelText: 'Altura',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    hintText: '1.75m',
                                  ),
                                )),
                            SizedBox(width: 50),
                            SizedBox(
                                width: 100,
                                child: TextFormField(
                                  autofocus: false,
                                  textAlign: TextAlign.left,
                                  controller: weightController,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                      fontWeight: FontWeight.normal),
                                    labelText: 'Peso',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    hintText: '78kg',
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(height: 50),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.primary),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )
                              )
                            ),
                            child: Text(
                              "Confirmar",
                              style: AppTextStyles.buttonText,
                            ),
                            onPressed: () {
                              saveUserInfo();
                            },
                          ),
                        ),
                      ],
                    );
                  }()
              ),
            )
        )
    );
  }
}

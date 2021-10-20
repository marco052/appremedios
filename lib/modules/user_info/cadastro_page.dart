import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_wiki/modules/home/home.dart';
import 'package:pharmacy_wiki/modules/medicines/medicamentos_page.dart';
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
  @override
  Widget build(BuildContext context) {

    Future<void> navigationPage() async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }

    return MaterialApp(
        title: "PharmacyWiki",
        theme: ThemeData(primaryColor: Colors.blue[200]),
        home: Scaffold(
            backgroundColor: Colors.blue[50],
            body: SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  color: Colors.blue[50],
                  child: () {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text("Podemos te conhecer melhor?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Antonio",
                                fontSize: 40,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 50,
                        ),
                        (Image.asset(AppImages.doctors)),
                        Row(children: <Widget>[
                          SizedBox(width: 50),
                          SizedBox(
                              width: 280,
                              child: TextFormField(
                                autofocus: false,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  labelText: 'Nome',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  labelText: 'Data de nascimento',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    labelText: 'Altura',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    hintText: '1.75m',
                                  ),
                                )),
                            SizedBox(width: 50),
                            SizedBox(
                                width: 100,
                                child: TextFormField(
                                  autofocus: false,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    labelText: 'Peso',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    hintText: '78kg',
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(height: 100),
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
                              navigationPage();
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

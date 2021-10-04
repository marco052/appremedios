import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/app/pages/Medicamentos/medicamentos_page.dart';
import 'package:pharmacy_wiki/main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

///Retorna a SplashScreen do app
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    // ignore: await_only_futures
    return await Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
            MedicamentosPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlue, Colors.white])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: SizedBox(
                  width: 250.0,
                  child: Image.asset(
                    "assets/imagens/logo.png",
                    fit: BoxFit.contain,
                  )))),
    );
  }
}

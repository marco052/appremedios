import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/app/pages/Medicamentos/medicamentos_page.dart';
import 'package:pharmacy_wiki/app/pages/cadastro_page.dart';
import 'package:pharmacy_wiki/main.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_images.dart';

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
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MedicamentosPage()));
  }

  @override
  Widget build(BuildContext context) {

    final window = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              colors: [Colors.white, Color(0xFFDFF3FD)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: SizedBox(
                  width: window.width * 0.8,
                  child: Image.asset(
                    AppImages.logoFull,
                    fit: BoxFit.contain,
                  )))),
    );
  }
}

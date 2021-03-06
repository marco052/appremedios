import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/modules/home/home.dart';
import 'package:pharmacy_wiki/modules/user_info/cadastro_page.dart';
import 'package:pharmacy_wiki/shared/data/connection.dart';
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
    Connection conn = Connection();
    var userInfo = await conn.getUserInfo();
    if (userInfo[0].value.length > 0) {
      return Timer(_duration, navigationPage);
    }
    else {
      return Timer(_duration, () => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CadastroPage()))
      });
    }
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/modules/medicines/medicamentos_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// Tempo que a SplashScreen ira permancer 
  startTime() async {
    var _duration = new Duration(seconds: 3);
    // ignore: await_only_futures
    return await Timer(_duration, navigationPage);
  }

  ///função para mudar para proxima pagina
  Future<void> navigationPage() async {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
          MedicamentosPage()
      )  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Icon(
          Icons.fingerprint,
          size: 150,
          color: Colors.white,
        ),
      )
    );
  }
}

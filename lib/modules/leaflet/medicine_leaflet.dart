import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class MedicineLeaflet extends StatelessWidget {
  
  final String alias;
  final String leaflet;
  final String indications;
  final String contraindications;
  final String posology;
  MedicineLeaflet(this.alias, this.leaflet, this.indications, this.contraindications, this.posology);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 340, top: 30),
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
              onPressed: () => {Navigator.pop(context)},
              label: Text(""),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text(alias, style: AppTextStyles.interRegularTitle,)),
          ),
          Expanded(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text('Descrição', style: AppTextStyles.interBoldText, textAlign: TextAlign.left,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(leaflet,
                    style: AppTextStyles.interTextArea, textAlign: TextAlign.justify),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text('Indicações', style: AppTextStyles.interBoldText, textAlign: TextAlign.left,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(indications,
                    style: AppTextStyles.interTextArea, textAlign: TextAlign.justify),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text('Contraindicações', style: AppTextStyles.interBoldText, textAlign: TextAlign.left,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(contraindications,
                    style: AppTextStyles.interTextArea, textAlign: TextAlign.justify),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text('Posologia', style: AppTextStyles.interBoldText, textAlign: TextAlign.left,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(posology,
                    style: AppTextStyles.interTextArea, textAlign: TextAlign.justify),
                  ),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
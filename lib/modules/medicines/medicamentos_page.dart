import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pharmacy_wiki/modules/leaflet/medicine_leaflet.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/services/medicine.dart' as medicineService;

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({Key? key}) : super(key: key);

  @override
  _MedicamentosPageState createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  TextEditingController editingController = TextEditingController();
  late Medicamento remedioAtual;
  bool isSearching = false;

  late ObservableList<Medicamento> remediosPesq =
      new ObservableList<Medicamento>();

  List<Medicamento> remedios = [];

  void loadList() async {
    var medicineList = await medicineService.listAll(); 
    for (int i = 0; i < medicineList.length; i++) {
      var aux = new Medicamento.contrutor(medicineList[i]['id'], medicineList[i]['alias'], medicineList[i]['description']);
      aux.indicacoes = medicineList[i]['indications'];
      aux.contraindicacoes = medicineList[i]['contraindications'];
      aux.posologia = medicineList[i]['posology'];
      remedios.add(
        aux
      );
    }
    remediosPesq.addAll(remedios);
  }

  @override
  void initState() {
    super.initState();
    editingController.text = '';
    loadList();
  }

  filterSearchResults(String query) {
    remediosPesq.clear();
    if (query.isNotEmpty) {
      remediosPesq.clear();
      remedios.forEach((rem) {
        if (rem.name.contains(query)) {
          remediosPesq.add(rem);
        }
      });
    } else {
      remediosPesq.addAll(remedios);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColors.primary,
        title: !isSearching
            ? Text("Medicamentos",
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontStyle: FontStyle.normal,
                  fontSize: 25.0,
                ))
            : TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                style: TextStyle(
                    fontFamily: 'Jost',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontFamily: 'Jost',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.white),
                    icon: Icon(Icons.search, color: Colors.white),
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    )),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      backgroundColor: Colors.white,
      body: Observer(
          builder: (_) => ListView.builder(
                itemCount: remediosPesq.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      color: Colors.grey[200],
                      child: ListTile( 
                        contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        leading: Icon(
                          Icons.medication,
                          size: 50,
                          color: Colors.blue,
                        ),
                        title: Text(
                          '${remediosPesq[index].name}',
                          style: TextStyle(
                              fontFamily: "Jost",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        dense: true,
                        trailing: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.find_in_page,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicineLeaflet(
                                        '${remediosPesq[index].name}',
                                        '${remediosPesq[index].bula}',
                                        '${remediosPesq[index].indicacoes}',
                                        '${remediosPesq[index].contraindicacoes}',
                                        '${remediosPesq[index].posologia}'
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                        onTap: () {
                          String verif = remediosPesq[index].name;
                          remediosPesq.forEach((rem) {
                            if (rem.name == verif) remedioAtual = rem;
                          });
                    
                          //Navigator.pushNamed(
                          //context, '/home/projetos/detalhesProjeto');
                        },
                      ),
                    ),
                  );
                },
              )),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pharmacy_wiki/modules/leaflet/medicine_leaflet.dart';
import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({Key? key}) : super(key: key);

  @override
  _MedicamentosPageState createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  TextEditingController editingController = TextEditingController();
  late Medicamentos remedioAtual;
  bool isSearching = false;

  List<Medicamentos> remedios = [
    new Medicamentos.contrutor(1, "rivotril", "remedio pra doido"),
    new Medicamentos.contrutor(2, "paracetamal", "remedio pra dor"),
    new Medicamentos.contrutor(3, "omeprazol", "remedio pra barriga"),
    new Medicamentos.contrutor(4, "viagra", "remedio pra broxa"),
    new Medicamentos.contrutor(5, "diazepan", "remedio pra estressado"),
  ];

  late ObservableList<Medicamentos> remediosPesq =
      new ObservableList<Medicamentos>();

  @override
  void initState() {
    super.initState();
    editingController.text = '';
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
        backgroundColor: Color(0xFF3050ff),
        title: !isSearching
            ? Text("Medicamentos",
                style: TextStyle(
                    fontFamily: 'Jost',
                    fontStyle: FontStyle.normal,
                    fontSize: 25.0,
                )
              )
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
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: ListTile(
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
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                      child: Icon(
                        Icons.find_in_page,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MedicineLeaflet()),
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
            );
          },
        )
      ),
    );
  }
}

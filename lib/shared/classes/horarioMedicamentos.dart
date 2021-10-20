import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';

class AlarmeMed {
  late String medicamento;
  late String descricao;
  late String horario;

  AlarmeMed();
  AlarmeMed.construtor(String med, String descricao, String horario) {
    this.medicamento = med;
    this.descricao = descricao;
    this.horario = horario;
  }
}

import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';

class AlarmeMed {
  late int id;
  late String medicamento;
  late String descricao;
  late String horario;
  late bool hasRestriction;

  AlarmeMed();
  AlarmeMed.construtor(int id, String med, String descricao, String horario,
      bool hasRestriction) {
    this.id = id;
    this.medicamento = med;
    this.descricao = descricao;
    this.horario = horario;
    this.hasRestriction = hasRestriction;
  }
}

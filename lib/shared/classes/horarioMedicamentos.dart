import 'package:pharmacy_wiki/shared/classes/medicamentos_class.dart';

class AlarmeMed {
  late String medicamento;
  late String descricao;
  late String horario;
  late bool hasRestriction;

  AlarmeMed();
  AlarmeMed.construtor(String med, String descricao, String horario, bool hasRestriction) {
    this.medicamento = med;
    this.descricao = descricao;
    this.horario = horario;
    this.hasRestriction = hasRestriction;
  }
}

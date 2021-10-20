class Medicamento {
  late num id;
  late String name;
  late String bula;
  late String hora;

  Medicamento();
  Medicamento.contrutor(num id, String name, String bula) {
    this.id = id;
    this.name = name;
    this.bula = bula;
  }
}

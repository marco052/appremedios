import 'dart:convert';

class Frequency {
  
  final bool isRoutine;
  final List<List<String>> schedule;
  final String noRoutine;

  Frequency({
    required this.isRoutine,
    required this.schedule,
    required this.noRoutine,
  });

  factory Frequency.fromJson(dynamic json) {
    var sch = (json['schedule'] as List).map((item) => (item as List).map((e) => e as String).toList()).toList();
    return(Frequency(isRoutine: json['isRoutine'], schedule: sch, noRoutine: json['noRoutine']));
  }

  Map<String, dynamic> toMap() {
    return {
      'isRoutine': isRoutine,
      'schedule': schedule,
      'noRoutine': noRoutine
    };
  }

  @override
  String toString() {

    JsonEncoder jsonEncoder = new JsonEncoder();
    String sch = jsonEncoder.convert(schedule);

    return "Frequency{isRoutine: $isRoutine, noRoutine: $noRoutine, schedule: '$sch}";
  }

  

}

// ! TABLE 
class ScheduledMedicine {
  final int id;
  final String name;
  final int quantity;
  final String type;
  final Frequency frequency;
  final int? reason;

  ScheduledMedicine({
    required this.id,
    required this.name,
    required this.quantity,
    required this.type,
    required this.frequency,
    required this.reason
  });

  Map<String, dynamic> toMap() {

    JsonEncoder jsonEncoder = new JsonEncoder();
    String feq = jsonEncoder.convert(frequency.toMap());

    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'type': type,
      'frequency': feq,
      'reason': reason
    };
  }

  @override
  String toString() {
    return "Medicine{id: $id, name: $name, quantity: $quantity, type: $type, frequency: '${frequency.toString()}', reason $reason}";
  }
}
// ! TABLE 
class User {
  final int id;
  final String alias;
  final String value;

  User({
    required this.id,
    required this.alias,
    required this.value
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'alias': alias,
      'value': value
    };
  }

  @override
  String toString() {
    return 'User{id: $id, alias: $alias, value: $value}';
  }
}
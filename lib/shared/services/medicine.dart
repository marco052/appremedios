import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> listAll() async {
  var url = Uri.parse('http://192.168.0.114:3000/medicine');
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  return json;
}



import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/casa_model.dart';

class CasaProvider {
  final String _url =  "https://flutter-varios-bc255.firebaseio.com";
  
  Future<bool> crearCasa(CasaModel casa) async{
  final url = '$_url/casas.json';

  final resp = await http.post(url, body: casaModelToJson(casa));

  final decodedData = json.decode(resp.body);
  print(decodedData);
  return true;
  }
}
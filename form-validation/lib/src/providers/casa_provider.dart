import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/casa_model.dart';
import '../models/casa_model.dart';
import '../models/casa_model.dart';

class CasaProvider {
  final String _url = "https://flutter-varios-bc255.firebaseio.com";

  Future<bool> crearCasa(CasaModel casa) async {
    final url = '$_url/casas.json';
    final resp = await http.post(url, body: casaModelToJson(casa));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<CasaModel>> cargarCasas() async {
    final url = '$_url/casas.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CasaModel> casas = List();

    if (decodedData == null) return [];
    decodedData.forEach((id, casa) {
      final casaTemp = CasaModel.fromJson(casa);
      casaTemp.id = id;
      casas.add(casaTemp);
    });

    print(casas);
    return casas;
  }

  Future<int> borrarCasa(String id) async {
    final url = '$_url/casas/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
}

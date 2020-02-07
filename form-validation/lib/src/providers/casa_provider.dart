import 'dart:convert';
import 'dart:io';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/casa_model.dart';

class CasaProvider {
  final String _url = "https://flutter-varios-bc255.firebaseio.com";
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearCasa(CasaModel casa) async {
    final url = '$_url/casas.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: casaModelToJson(casa));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<CasaModel>> cargarCasas() async {
    final url = '$_url/casas.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<CasaModel> casas = List();

    if (decodedData == null) return [];
    decodedData.forEach((id, casa) {
      final casaTemp = CasaModel.fromJson(casa);
      casaTemp.id = id;
      casas.add(casaTemp);
    });

    print(casas[0].id);
    return casas;
  }

  Future<int> borrarCasa(String id) async {
    final url = '$_url/casas/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
  Future<bool> editarCasa(CasaModel casa) async {
    final url = '$_url/casas/${casa.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: casaModelToJson(casa));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<String> subirImagen(File imagen)async{

    final url = Uri.parse('https://api.cloudinary.com/v1_1/axeljovannyqt/image/upload?upload_preset=gyyklcsl');
    final mimeTipe = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath('file', imagen.path,
     contentType: MediaType(mimeTipe[0], mimeTipe[1])
     );

    //aqui se pueden subir mas archivos
     imageUploadRequest.files.add(file);
     final streamedResponse = await imageUploadRequest.send();

     final resp = await http.Response.fromStream(streamedResponse);

     if (resp.statusCode != 200 && resp.statusCode != 201) {
       print('algo salio mal');
       print(resp.body);
       return null;
     } 

     final respData = json.decode(resp.body);
     return respData['secure_url'];
  }
}

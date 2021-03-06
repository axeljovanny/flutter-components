import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

import '../models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '7695e7a4e25d13cdfdc89ce6de2e7590';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage=0;


  //Stream tuberia
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //entrada y slida
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>>get popularesStream => _popularesStreamController.stream;

//cerrar stream
  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return _procesarRespuesta(url);
    
  }


  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);

    //usar Stream solo agrego info al stream.
    _populares.addAll(resp);
    popularesSink(_populares);
    
    return resp;
  }
}

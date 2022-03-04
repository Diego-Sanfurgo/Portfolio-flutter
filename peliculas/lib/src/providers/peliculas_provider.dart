import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '523da71496340ec4a2cd26512c035ef4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //La función debe cumplir que recibe una lista de películas, no conviene dejarlo como dynamic
  //porque podría haber errores a la hora de escrtura
  //Esta función apunta a la función del Stream Controller para agregar elementos
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Con esta función se escuchan los datos
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  //El metodo regresa un future que hace la peticion al
  //servicio y retorna las peliculas ya mapeadas
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //El constructor se va a encargar de arrer cada uno de los resultados que esten en
    //la lista y generar el modelo.
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //regreso la lista de peliculas
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    //Le paso la url y el camino sin los argumentos
    //También se le tiene que agregar el numero de version de la API al 2do parametro
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    //Si estoy cargando datos, devuelvo un arreglo vacío para no cargar más de lo necesario
    if (_cargando) return [];

    _cargando = true;
    //La primera vez que se ejecuta tiene el valor de 0, +1 y empieza en la primer página
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);

    popularesSink(_populares);

    //Ya tengo la respuesta y ahora no estoy cargando datos
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliID) async {
    final url = Uri.https(_url, '3/movie/$peliID/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    //Await sirve para esperar la respuesta
    final resp = await http.get(url);
    final decodedData =
        json.decode(resp.body); //Toma el body y lo transforma en un map
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }
}

//Manejar todas las preferencias del usuario

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //Ninguna de estas propiedades se usa
  /*  bool _colorSecundario;
  int _genero;
  String _nombre;
 */

  //GETTER Y SETTER del GENERO
  get genero {
    //Si no existe el género, la propiedad por defecto es un 1
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  //GETTER Y SETTER del COLOR SECUNDARIO
  get colorSecundario {
    //Si no existe el género, la propiedad por defecto es un 1
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  //GETTER Y SETTER del NOMBRE DEL USUARIO
  get nombreUsuario {
    //Si no existe el género, la propiedad por defecto es un 1
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  //GETTER Y SETTER del ULTIMA PAGINA
  get ultimaPagina {
    //Si no existe el género, la propiedad por defecto es un 1
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}

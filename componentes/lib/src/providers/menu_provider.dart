//Solo necesitamos un elemento de este paquete.
//RpptBundle tiene lo que necesito para leer el JSON
import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];

  //Solo vamos a necesitar 1 instancia de esta clase.
  _MenuProvider() {
    // _cargarData();
  }

  //Para leer el archivo JSON necesitamos un paquete propio de flutter
  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/menu_opts.json');

    Map dataMap = json.decode(resp);
    // print(dataMap['rutas']);
    opciones = dataMap['rutas'];

    return opciones;
  }
}

//Esto solo expone la instancia creada de menuProvider
final menuProvider = new _MenuProvider();

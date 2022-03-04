import 'package:flutter/material.dart';

import 'package:componentes/src/utils/icono_string_util.dart';
import 'package:componentes/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Componentes')),
      body: _lista(),
      backgroundColor: Colors.deepPurple[50],
    );
  }

  Widget _lista() {
    // menuProvider.cargarData()

    return FutureBuilder(
      future: menuProvider.cargarData(),
      //initialData es informacion que tiene por defecto mientras no sea resuelto el future
      //Es opcional
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue[900]),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);

          //El context es el buildContext que tenemos. Sirve para saber que pagina sigue y a cual regreso
          //Con esta ruta, todos los botones nos envian a AlertPage
          /* final route = MaterialPageRoute(builder: (context) => AlertPage());
          Navigator.push(context, route); */
        },
      );

      opciones
        ..add(widgetTemp)
        ..add(Divider(
          color: Colors.black,
        ));
    });

    return opciones;
  }
}

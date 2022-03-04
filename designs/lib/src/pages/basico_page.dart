import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiluTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiluSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearImagen(),
            _crearTitulo(),
            _crearAcciones(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto(),
          ],
        ),
      ),
    );
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHw%3D&w=1000&q=80'),
        height: 300.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Río en el bosque', style: estiluTitulo),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    'A beautiful landscape',
                    style: estiluSubtitulo,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              size: 30.0,
            ),
            Text(
              '41',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _accion(Icons.call, 'CALL'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'SHARE'),
      ],
    );
  }

  Widget _accion(IconData icon, String texto) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(
          height: 5.0,
        ),
        Text(texto, style: TextStyle(fontSize: 15.0, color: Colors.blue)),
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          'Sint veniam pariatur reprehenderit reprehenderit deserunt mollit id. In qui laboris sit pariatur nulla qui ipsum occaecat. Duis ipsum sit laborum duis ad cupidatat sunt nostrud aliqua. Qui veniam in id exercitation tempor dolor ipsum proident velit commodo dolor officia aliquip laboris. Cillum laboris irure excepteur duis. Proident fugiat in ad adipisicing voluptate. Ea est exercitation reprehenderit enim consectetur exercitation.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

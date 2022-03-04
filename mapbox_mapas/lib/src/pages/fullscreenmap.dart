import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:http/http.dart' as http;

class FullScreenMap extends StatefulWidget {
  static final String API_KEY =
      'pk.eyJ1IjoiZHNhbmZ1cmdvIiwiYSI6ImNrbXR6bnQ2bzB3aDkycXJzcHI1ZG10OGYifQ.vIQroLjpuQAfGhWgL9E31Q';

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  String selectedStye = 'mapbox://styles/dsanfurgo/ckmu0wy7i2l5f17my3q4lp612';
  final oscuroStyle = 'mapbox://styles/dsanfurgo/ckmu0wy7i2l5f17my3q4lp612';
  final streetStyle = 'mapbox://styles/dsanfurgo/ckmu107v40kba17t4m1goecx9';

  final center = LatLng(-32.9206273, -68.833756);

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //Simbolos
        FloatingActionButton(
          child: Icon(Icons.emoji_symbols),
          onPressed: () {
            mapController.addSymbol(SymbolOptions(
              geometry: center,
              textField: 'Montana creada aqui',
              textOffset: Offset(0, 2),
              iconImage: 'assetImage',
              // iconSize: 3,
            ));
          },
        ),
        SizedBox(height: 5),

        //ZoomIn
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        SizedBox(height: 5),
        //Zoom out
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        SizedBox(height: 15),

        //Cambiar estilo de la app
        FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            if (selectedStye == oscuroStyle) {
              selectedStye = streetStyle;
            } else {
              selectedStye = oscuroStyle;
            }
            _onStyleLoaded();

            setState(() {});
          },
        )
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStye,
      accessToken: FullScreenMap.API_KEY,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: center, zoom: 14.0),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_map/app/views/acceso_gps_view.dart';
import 'package:simple_map/app/views/loading_view.dart';
import 'package:simple_map/app/views/mapa_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Map',
      home: LoadingView(),
      routes: {
        'mapa': (_) => MapaView(),
        'loading': (_) => LoadingView(),
        'acceso_gep': (_) => AccesoGpsView()
      },
    );
  }
}

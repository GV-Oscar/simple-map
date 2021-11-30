import 'package:flutter/material.dart';
import 'package:simple_map/app/customs/markers/markers.dart';


class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            // painter: OriginMarkerPainter(duration: 30),
            painter: DestinyMarkerPainter(
            descripcion: 'Jardín Infantil Paraiso De Los Niños', 
            mt: 6780
            )
          ),
        ),
      ),
    );
  }
}

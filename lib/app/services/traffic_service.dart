import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/models/traffic_response.dart';

class TrafficService {
  // Singleton
  TrafficService._();
  static final TrafficService _instance = TrafficService._();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();

  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final String _apiKey =
      'pk.eyJ1IjoiZ3Zvc2NhciIsImEiOiJja3Z1NWh1cGIwdHh2Mm5xZjlraDAxdXIwIn0.PpI8ffJm52tIzyPnz6xA3g';

  /// Obtener ruta de navegacion apartir de un punto de origen y destino.
  Future<TrafficResponse?> getNavigationRoute(
      LatLng origin, LatLng destiny) async {
    try {
      print('Origen  : $origin');
      print('Destino : $destiny');

      final coordinates =
          '${origin.longitude},${origin.latitude};${destiny.longitude},${destiny.latitude}';
      final url = '$_baseUrl/mapbox/driving/$coordinates';

      final resp = await this._dio.get(url, queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'overview': 'simplified',
        'steps': 'false',
        'access_token': _apiKey,
        'language': 'es',
      });

      final data = TrafficResponse.fromJson(resp.data);
      print(data);

      return data;
    } catch (e) {
      print('Ocurrio un error inesperado: $e');
      return null;
    }
  }
}

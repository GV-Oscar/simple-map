import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/helpers/debouncer.dart';
import 'package:simple_map/app/models/geocoding_response.dart';
import 'package:simple_map/app/models/traffic_response.dart';

class TrafficService {
  // Singleton
  TrafficService._();
  static final TrafficService _instance = TrafficService._();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer = Debouncer<String>(duration: const Duration(milliseconds: 400 ));

  /// Stream que emite respuestas de geocodificacion
  final StreamController<GeocodingResponse> _suggestionsStreamCtrl = StreamController<GeocodingResponse>.broadcast();
  Stream<GeocodingResponse> get suggestionsStream => _suggestionsStreamCtrl.stream;


  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final String _apiKey =
      'pk.eyJ1IjoiZ3Zvc2NhciIsImEiOiJja3Z1NWh1cGIwdHh2Mm5xZjlraDAxdXIwIn0.PpI8ffJm52tIzyPnz6xA3g';

  final String _geocodingApi = 'https://api.mapbox.com/geocoding/v5';

  /// Obtener ruta de navegacion apartir de un punto de origen y destino.
  Future<TrafficResponse?> getNavigationRoute(LatLng origin, LatLng destiny) async {
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

  /// Obtener busqueda de ubicación
  Future<GeocodingResponse> getLocationSearch(String query, LatLng proximity) async {

    print('Buscando!!!');

    try {
      final url = '$_geocodingApi/mapbox.places/$query.json';

      final response = await _dio.get(url, queryParameters: {
        'country': 'co',
        //'limit': '6',
        'proximity': '${proximity.longitude},${proximity.latitude}',
        //'types': 'address',
        'language': 'es',
        'autocomplete': true,
        'fuzzyMatch': true,
        'routing': true,
        'access_token': _apiKey,
      });

      final data = geocodingResponseFromJson(response.data);

      return data;
    } catch (e) {
      print('Ocurrio un error: $e');
      return GeocodingResponse(features: []);
    }
  }


  /// Obtener sugerencias por query
  void getSuggestionsByQuery( String query, LatLng proximity ) {
  debouncer.value = '';
  debouncer.onValue = ( value ) async {
    final resultados = await getLocationSearch(value, proximity);
    _suggestionsStreamCtrl.add(resultados);
  };

  final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
    debouncer.value = query;
  });

  Future.delayed(const Duration(milliseconds: 201)).then((_) => timer.cancel()); 

}
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Resultado de busqueda de destiono
class SearchResult {
  /// Devuelve true si la busqueda se cancelo, false en caso contrario.
  final bool isSearchCanceled;

  /// Devuelve true si la busqueda se debe hacer manual en el mapa, false en caso contrario.
  final bool isManualSearch;

  /// Coordenadas de latitud y longitud del lugar
  final LatLng? latLng;

  /// Nombre del lugar
  final String? placeName;

  /// Descripcion del lugar
  final String? placeDescription;

  SearchResult(
      {this.isSearchCanceled = false,
      this.isManualSearch = false,
      this.latLng,
      this.placeName,
      this.placeDescription});
}

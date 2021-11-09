part of 'map_bloc.dart';

@immutable
class MapState {
  /// Devuelve true si el mapa esta listo para usarse, en caso contrario false.
  final bool isMapReady;

  /// Devuelve true si la ruta esta trazada, en caso contrario false.
  final bool isTraceRoute;

  /// Devuelve true si se está siguiendo al usuario, en caso contrario false.
  final bool isTrackingUser;

  /// Polilineas de las rutas.
  final Map<String, Polyline>? polylines;

  /// Ubicacion central en el mapa.
  final LatLng? centerLocation;

  MapState({
    this.isMapReady = false,
    this.isTraceRoute = false,
    this.isTrackingUser = false,
    this.centerLocation,
    Map<String, Polyline>? polylines
  })
  : polylines = polylines ?? <String, Polyline>{};

  MapState copyWith({
    bool? isMapReady,
    bool? isTraceRoute,
    bool? isTrackingUser,
    LatLng? centerLocation,
    Map<String, Polyline>? polylines
  }) => MapState(
    isMapReady: isMapReady ?? this.isMapReady,
    isTraceRoute: isTraceRoute ?? this.isTraceRoute,
    isTrackingUser: isTrackingUser ?? this.isTrackingUser,
    centerLocation: centerLocation ?? this.centerLocation,
    polylines: polylines ?? this.polylines
  );
}

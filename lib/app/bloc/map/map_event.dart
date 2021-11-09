part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

/// Evento para controlar cuando el mapa este listo para usarse.
class OnMapReady extends MapEvent {}

/// Evento para controlar las actualizaciones de ubicacion.
class OnLocationUpdate extends MapEvent {
  final LatLng latLng;
  OnLocationUpdate(this.latLng);
}

/// Evento para controlar el trazo de my ruta
class OnTraceRoute extends MapEvent {
  // final bool isTraceRoute;
  // OnTraceRoute(this.isTraceRoute);
  OnTraceRoute();
}

/// Evento para controlar seguimiento de usuario.
class OnTrackingUser extends MapEvent {
  OnTrackingUser();
}

/// Evento para contral seguimiento de movimiento de mapa.
class OnMoveMap extends MapEvent {
  final LatLng centerLocation;

  OnMoveMap(this.centerLocation);
}

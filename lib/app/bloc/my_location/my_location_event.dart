part of 'my_location_bloc.dart';

@immutable
abstract class MyLocationEvent {}

/// Evento de Cambio en la Ubicacion
class OnChangeLocation extends MyLocationEvent {
  /// Ubicacion.
  final LatLng location;

  OnChangeLocation(this.location);
}

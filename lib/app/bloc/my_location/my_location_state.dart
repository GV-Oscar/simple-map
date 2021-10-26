part of 'my_location_bloc.dart';

/// Esta clase define el estado del bloc de mi ubicacion.
/// Vamos a trabajar con un solo estado, por eso no trabajamos con herencia de estado
@immutable
class MyLocationState {
  /// Devuelve true si se esta rastreando la ubicacion,
  /// en caso contrario false.
  final bool isTracking;

  /// Devuelve true si existe una ultima ubicacion conocida,
  /// en caso contrario false.
  final bool existsLocation;

  /// Devuelve las coordenadas de latitud y longitud de la ultima
  /// ubicacion conocida, en caso contrario null.
  final LatLng? lastLocation;

  MyLocationState(
      {this.isTracking = false,
      this.existsLocation = false,
      this.lastLocation});

  /// Este metodo permite realizar una copia de todo el estado de mi ubicación.
  MyLocationState copyWith({
    bool? isTracking,
    bool? existsLocation,
    LatLng? lastLocation
  }) => MyLocationState(
    isTracking: isTracking ?? this.isTracking,
    existsLocation: existsLocation ?? this.existsLocation,
    lastLocation: lastLocation ?? this.lastLocation
  );
}

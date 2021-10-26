part of 'map_bloc.dart';

@immutable
class MapState {
  /// Devuelve true si el mapa esta listo para usarse, en caso contrario false.
  final bool isMapReady;

  const MapState({this.isMapReady = false});

  MapState copyWith({bool? isMapReady}) =>
      MapState(isMapReady: isMapReady ?? this.isMapReady);
}

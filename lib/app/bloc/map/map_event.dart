part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

/// Evento para informar que el mapa fue cargado y esta listo para usarse.
class OnMapReady extends MapEvent {}

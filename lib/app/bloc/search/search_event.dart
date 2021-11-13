part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

/// Evento para buscar ubicacion manualmente.
class OnFindManualLocation extends SearchEvent {
  final bool isFindManualLocation;

  OnFindManualLocation(this.isFindManualLocation);
}

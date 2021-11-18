part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

/// Evento para buscar ubicacion manualmente.
class OnFindManualLocation extends SearchEvent {
  final bool isFindManualLocation;

  OnFindManualLocation(this.isFindManualLocation);
}

/// Evento para controlar cuando se va agregar una búsqueda al historial
class OnAddSearchToHistory extends SearchEvent {
  /// Resultado de busqueda
  final SearchResult result;

  OnAddSearchToHistory(this.result);
}

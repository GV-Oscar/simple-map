part of 'search_bloc.dart';

@immutable
class SearchState {
  /// Devuelve true si la busqueda es manual en el mapa, false en caso contrario.
  final bool isManualSearch;

  /// Historial de busquedas
  final List<SearchResult> historical;

  const SearchState({
    this.isManualSearch = false,
    List<SearchResult>? historical
  }) : historical = (historical == null) ? const <SearchResult>[] : historical;

  SearchState copyWith({
    bool? isManualSearch,
    List<SearchResult>? historical,
  }) => SearchState(
          isManualSearch: isManualSearch ?? this.isManualSearch,
          historical: historical ?? this.historical
        );
}

part of 'search_bloc.dart';

@immutable
class SearchState {
  /// Devuelve true si la busqueda es manual en el mapa, false en caso contrario.
  final bool isManualSearch;

  const SearchState({this.isManualSearch = false});

  SearchState copyWith({
    bool? isManualSearch,
  }) => SearchState(
    isManualSearch: isManualSearch ?? this.isManualSearch
  );
}

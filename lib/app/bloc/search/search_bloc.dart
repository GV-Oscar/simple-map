import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_map/app/models/search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {

    // Registrar oyente de evento de busqueda de ubicacion manual.
    on<OnFindManualLocation>(_onFindManualLocation);

    // Registrar oyente de evento de agregar busqueda al historial
    on<OnAddSearchToHistory>(_onAddSearchToHistory);
  }

  /// Se dispara cuando se detecta un evento de busqueda de ubicacion manual.
  FutureOr<void> _onFindManualLocation(OnFindManualLocation event, Emitter<SearchState> emit) {
    print('_onFindManualLocation');
    emit(state.copyWith(isManualSearch: event.isFindManualLocation));
  }

  /// Se dispara cuando se detecta un evento para agregar una busqueda al historial
  FutureOr<void> _onAddSearchToHistory(OnAddSearchToHistory event, Emitter<SearchState> emit) {
    final exist = state.historical.where(
      (result) => result.placeName == event.result.placeName
    ).length;

    if (exist == 0){
      final newHistorical = [...state.historical, event.result];
      emit(state.copyWith(historical: newHistorical));
    }
  }
}

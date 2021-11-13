import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    // Registrar oyente de evento de busqueda de ubicacion manual.
    on<OnFindManualLocation>(_onFindManualLocation);
  }

  /// Se dispara cuando se detecta un evento de busqueda de ubicacion manual.
  FutureOr<void> _onFindManualLocation(OnFindManualLocation event, Emitter<SearchState> emit) {
    print('_onFindManualLocation');
    emit(state.copyWith(isManualSearch: event.isFindManualLocation));
  }
}

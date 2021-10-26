import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

/// Bloc que gestiona la base de ubicacion del usuario
class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  /// Construir el bloc con el estado inicial
  MyLocationBloc() : super(MyLocationState()) {
    // Registrar evento de cambio de ubicacion
    on<OnChangeLocation>(_onChangeLocation);
  }

  /// Suscripcion de eventos de posision.
  late StreamSubscription<Position> _positionSubscription;

  /// Comenzar a rastrear la ubicación del usuario.
  void startTrackingUserLocation() {
    // Establecer oyente de cambios de ubicacion.
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high, // Precision deseada
      distanceFilter: 10, // Distancia en metros para obtener actualizacion
    ).listen((Position position) {
      if (position != null) {
        final latlng = LatLng(position.latitude, position.longitude);
        add(OnChangeLocation(latlng));
      }
    });
  }

  /// Dejar de rastrear la ubicación del usuario.
  void stopTrackingUserLocation() {
    _positionSubscription.cancel();
  }

  /// Se dispara cuando se detecta un cambio en la ubicación
  FutureOr<void> _onChangeLocation(
      OnChangeLocation event, Emitter<MyLocationState> emit) {
    // Emitir nuevo evento de cambio en la ubicacion.
    emit(state.copyWith(existsLocation: true, lastLocation: event.location));
  }

  /// Obtener mi ultima ubicacion conocida
  LatLng? get lastLocation => state.lastLocation;
}

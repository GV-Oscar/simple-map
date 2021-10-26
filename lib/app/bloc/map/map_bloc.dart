import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:simple_map/app/themes/uber_map_style.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    // Registrar oyente de envento de mapa listo.
    on<OnMapReady>(_onMapReady);
  }

  late GoogleMapController _mapCtrl;

  /// Inicializar mapa
  void initializeMap(GoogleMapController controller) {
    if (!state.isMapReady) {
      _mapCtrl = controller;

      // Establecer estilo de mapa
      _mapCtrl.setMapStyle(jsonEncode(uberMapStyle));

      // Publicar evento de mapa listo.
      add(OnMapReady());
    }
  }

  /// Este evento se recibe cuando el mapa se encuentra listo.
  FutureOr<void> _onMapReady(OnMapReady event, Emitter<MapState> emit) {
    emit(state.copyWith(isMapReady: true));
  }

  /// Mover camara
  void moveCamera(LatLng? latLng) {
    if (state.isMapReady && latLng != null) {
      final cameraUpdate = CameraUpdate.newLatLng(latLng);
      _mapCtrl.animateCamera(cameraUpdate);
      // final cameraPosition = CameraPosition(target: latLng, zoom: 16);
      // _mapCtrl.animateCamera(CameraUpdate.newCameraPosition(camera));
    }
  }
}

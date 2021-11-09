import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:simple_map/app/themes/uber_map_style.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    // Registrar oyente para envento de mapa listo.
    on<OnMapReady>(_onMapReady);

    // Registrar oyente para evento de actualizacion de ubicacion.
    on<OnLocationUpdate>(_onLocationUpdate);

    // Registrar oyente para evento de trazo de ruta
    on<OnTraceRoute>(_onTraceRoute);

    // Registrar oyente para evento de seguimiento de usuario
    on<OnTrackingUser>(_onTrackingUser);

    // Registrar oyente para evento de movimiento de mapa
    on<OnMoveMap>(_onMoveMap);
  }

  // Controlador de mapa
  late GoogleMapController _mapCtrl;

  // Polylines
  Polyline _myPersonalRoute = Polyline(
      polylineId: PolylineId('my_personal_route'),
      width: 4,
      color: Colors.transparent);

  Polyline _myOptimalRoute =
      Polyline(polylineId: PolylineId('my_optimal_route'), width: 4);

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

  /// Mover camara
  void moveCamera(LatLng? latLng) {
    if (state.isMapReady && latLng != null) {
      final cameraUpdate = CameraUpdate.newLatLng(latLng);
      _mapCtrl.animateCamera(cameraUpdate);
      // final cameraPosition = CameraPosition(target: latLng, zoom: 16);
      // _mapCtrl.animateCamera(CameraUpdate.newCameraPosition(camera));
    }
  }

  /// Se dispara cuando se recibe el evento de mapa listo.
  FutureOr<void> _onMapReady(OnMapReady event, Emitter<MapState> emit) {
    emit(state.copyWith(isMapReady: true));
  }

  /// Se dispara cuando se recibe el evento de actualizacion de ubicacion.
  FutureOr<void> _onLocationUpdate(
      OnLocationUpdate event, Emitter<MapState> emit) {
    if (state.isTrackingUser) {
      // Si se esta rastreando al usuario, mover la camara.
      moveCamera(event.latLng);
    }

    List<LatLng> points = [..._myPersonalRoute.points, event.latLng];
    _myPersonalRoute = _myPersonalRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines!['my_personal_route'] = _myPersonalRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  /// Se dispara cuando se recibe el evento de trazo de ruta
  FutureOr<void> _onTraceRoute(OnTraceRoute event, Emitter<MapState> emit) {
    if (!state.isTraceRoute) {
      _myPersonalRoute = _myPersonalRoute.copyWith(colorParam: Colors.black87);
    } else {
      _myPersonalRoute =
          _myPersonalRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines!['my_personal_route'] = _myPersonalRoute;

    emit(state.copyWith(
        isTraceRoute: !state.isTraceRoute, polylines: currentPolylines));
  }

  /// Se dispara cuando se recibe el evento de rastrear usuario
  FutureOr<void> _onTrackingUser(OnTrackingUser event, Emitter<MapState> emit) {
    // Comprobar si se esta rastreando al usuario
    if (!state.isTrackingUser) {
      // mover la camara de inmediato
      moveCamera(_myPersonalRoute.points[_myPersonalRoute.points.length - 1]);
    }
    // Establecer el opuesto
    emit(state.copyWith(isTrackingUser: !state.isTrackingUser));
  }

  /// Se dispara cuando se recibe un evento de movimiento en el mapa
  FutureOr<void> _onMoveMap(OnMoveMap event, Emitter<MapState> emit) {
    print('_onMoveMap ${event.centerLocation}');
    if (event.centerLocation != null) {
      emit(state.copyWith(centerLocation: event.centerLocation));
    }
  }
}

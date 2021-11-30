import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/bloc/map/map_bloc.dart';
import 'package:simple_map/app/bloc/my_location/my_location_bloc.dart';
import 'package:simple_map/app/widgets/widgets.dart';

class MapaView extends StatefulWidget {
  const MapaView({Key? key}) : super(key: key);

  @override
  State<MapaView> createState() => _MapaViewState();
}

class _MapaViewState extends State<MapaView> {
  late MyLocationBloc _locationBloc;

  @override
  void initState() {
    _locationBloc = BlocProvider.of<MyLocationBloc>(context);
    _locationBloc.startTrackingUserLocation();
    super.initState();
  }

  @override
  void dispose() {
    _locationBloc.stopTrackingUserLocation();
    // BlocProvider.of<MyLocationBloc>(context).stopTrackingUserLocation();
    // context.read<MyLocationBloc>().stopTrackingUserLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlocBuilder<MyLocationBloc, MyLocationState>(
            builder: (context, state) => createMap(context, state),
          ),

          // hacer el toggle cuando la busqueda es manual, en el mapa.
          Positioned(top: 30, child: Searchbar()),

          MarkerManual()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnMyLocation(onPressed: onClickBtnMyLocation),
          BtnTrackUser(),
          BtnMyRoute(onPressed: onClickBtnMyRoute),
        ],
      ),
    );
  }

  Widget createMap(BuildContext context, MyLocationState state) {
    final size = MediaQuery.of(context).size;
    // Si no hay una ubicación, indicar al usuario que se esta ubicando
    if (!state.existsLocation) return const Center(child: Text('Ubicando...'));

    final _mapBloc = BlocProvider.of<MapBloc>(context);

    final initialCameraPosition = CameraPosition(
        target: state.lastLocation!,
        //zoom: 15.0,
        zoom: 16);

    _mapBloc.add(OnLocationUpdate(state.lastLocation!));

    return BlocBuilder<MapBloc, MapState>(
      builder: (_, __) {
        return GoogleMap(
          initialCameraPosition: initialCameraPosition,
          onMapCreated: _mapBloc.initializeMap,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onCameraMove: onCameraMove,
          polylines: _mapBloc.state.polylines.values.toSet(),
          markers: _mapBloc.state.markers.values.toSet(),
        );
      },
    );
  }

  onClickBtnMyLocation() {
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    _mapBloc.moveCamera(_locationBloc.lastLocation);
  }

  void onClickBtnMyRoute() {
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    _mapBloc.add(OnTraceRoute());
  }

  void onCameraMove(CameraPosition position) {
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    _mapBloc.add(OnMoveMap(position.target));
  }
}

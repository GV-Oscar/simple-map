import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/bloc/map/map_bloc.dart';
import 'package:simple_map/app/bloc/my_location/my_location_bloc.dart';
import 'package:simple_map/app/widgets/widgets.dart';

class MapaView extends StatefulWidget {
  @override
  State<MapaView> createState() => _MapaViewState();
}

class _MapaViewState extends State<MapaView> {
  late MapBloc _mapBloc;
  late MyLocationBloc _locationBloc;

  @override
  void initState() {
    _locationBloc = BlocProvider.of<MyLocationBloc>(context);
    _mapBloc = BlocProvider.of<MapBloc>(context);

    _locationBloc.startTrackingUserLocation();

    // context.read<MyLocationBloc>().startTrackingUserLocation();
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
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (context, state) {
          return Center(
            child: createMap(state),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [BtnMyLocation(onPressed: onClickBtnMyLocation)],
      ),
    );
  }

  Widget createMap(MyLocationState state) {
    if (!state.existsLocation) return Text('Ubicando...');

    final cameraPosition = CameraPosition(
      target: state.lastLocation!,
      zoom: 15.0,
    );

    Completer<GoogleMapController> _controller = Completer();

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      onMapCreated: _mapBloc.initializeMap,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }

  onClickBtnMyLocation() {
    _mapBloc.moveCamera(_locationBloc.lastLocation);
  }
}

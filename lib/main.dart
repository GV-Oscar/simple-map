import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_map/app/bloc/map/map_bloc.dart';
import 'package:simple_map/app/bloc/my_location/my_location_bloc.dart';
import 'package:simple_map/app/bloc/search/search_bloc.dart';
import 'package:simple_map/app/views/acceso_gps_view.dart';
import 'package:simple_map/app/views/loading_view.dart';
import 'package:simple_map/app/views/mapa_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyLocationBloc()),
        BlocProvider(create: (_) => MapBloc()),
        BlocProvider(create: (_) => SearchBloc())

        ///
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Map',
        home: LoadingView(),
        routes: {
          'mapa': (_) => MapaView(),
          'loading': (_) => LoadingView(),
          'acceso_gep': (_) => AccesoGpsView()
        },
      ),
    );
  }
}

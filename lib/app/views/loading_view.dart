import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_map/app/helpers/helpers.dart';
import 'package:simple_map/app/views/acceso_gps_view.dart';
import 'package:simple_map/app/views/mapa_view.dart';

class LoadingView extends StatefulWidget {
  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with WidgetsBindingObserver {
 
 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  /// Se dispara cuando hay un cambió el estado del ciclo de vida de la aplicación.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('===> $state');
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(context, navigatePageFadeIn(context, MapaView()));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return (Center(child: Text(snapshot.data!)));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 24,
                      height: 24,
                      child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 1)),
                  const SizedBox(
                    height: 5,
                  ),
                  //Text('Cargando...')
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> checkGpsAndLocation(BuildContext context) async {

    // Permiso de ubicacion
    final permisoGPS = await Permission.location.isGranted;
    // Gps activado
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    

    if (permisoGPS && gpsActivo) {
      // Ir a mapa
      Navigator.pushReplacement(context, navigatePageFadeIn(context, MapaView()));
      return '';
    } else if (!permisoGPS) {
      // Ir a pedir permiso
      Navigator.pushReplacement(context, navigatePageFadeIn(context, AccesoGpsView()));
      return 'El permiso de GPS es necesario';
    } else {
      // Solicitar activar ubicacion
      Geolocator.openLocationSettings();
      return 'Active la ubicación';
    }

    // await Future.delayed(Duration(milliseconds: 1000));

    // Navigator.pushReplacement(context, navigatePageFadeIn(context, AccesoGpsView()));
  }
}

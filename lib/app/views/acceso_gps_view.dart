import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsView extends StatefulWidget {
  @override
  State<AccesoGpsView> createState() => _AccesoGpsViewState();
}

class _AccesoGpsViewState extends State<AccesoGpsView>
    with WidgetsBindingObserver {
  
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
      if (await Permission.location.isGranted) {
        print('===> permiso gps consedido');
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Necesitamos acceso al GPS'),
            MaterialButton(
                child: Text(
                  'Solicitar Acceso',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                shape: StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () async {
                  // TODO: verificar permisos

                  // Comprobar estado de permiso de ubicacion.
                  final status = await Permission.location.request();

                  print(status);
                  accesoGPS(status);
                })
          ],
        ),
      ),
    );
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        // El usuario denegó el acceso a la función solicitada.
        break;
      case PermissionStatus.granted:
        // El usuario otorgó acceso a la función solicitada.

        Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.restricted:
      // El sistema operativo denegó el acceso a la función solicitada.
      // El usuario no puede cambiar el estado de esta aplicación,
      // posiblemente debido a restricciones activas, como controles parentales.
      // Solo compatible con iOS.
      case PermissionStatus.limited:
      // El usuario ha autorizado esta aplicación para acceso limitado.
      // Solo compatible con iOS (iOS14 +).
      case PermissionStatus.permanentlyDenied:
        // El permiso para la función solicitada se deniega permanentemente,
        // el cuadro de diálogo de permiso no se mostrará al solicitar este permiso.
        // El usuario aún puede cambiar el estado del permiso en la configuración.
        //Solo compatible con Android.

        openAppSettings();
        break;
    }
  }
}

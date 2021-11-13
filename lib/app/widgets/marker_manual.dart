part of 'widgets.dart';

class MarkerManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isManualSearch) {
          return _BuildMarker();
        }
        return Container();
      },
    );
  }
}

class _BuildMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Boton regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 300),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    final blocSearch = BlocProvider.of<SearchBloc>(context);
                    blocSearch.add(OnFindManualLocation(false));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )),
            ),
          ),
        ),

        // Marcador
        Center(
          child: Transform.translate(
              offset: Offset(0, -20),
              child: BounceInDown(
                child: Icon(
                  Icons.location_on,
                  size: 50,
                ),
              )),
        ),

        // Boton de confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            duration: Duration(milliseconds: 300),
            child: MaterialButton(
                height: 40,
                minWidth: size.width - 120,
                child: Text('Confirmar destino',
                    style: TextStyle(color: Colors.white)),
                color: Colors.black,
                shape: StadiumBorder(),
                splashColor: Colors.transparent,
                elevation: 0,
                onPressed: () => getRouteCoordinates(context)),
          ),
        )
      ],
    );
  }

  /// Obtener coordenadas de ruta.
  void getRouteCoordinates(BuildContext context) async {
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final origin = BlocProvider.of<MyLocationBloc>(context).state.lastLocation;
    final destiny = mapBloc.state.centerLocation;

    if (origin != null && destiny != null) {
      searchAlert(context);
      final trafficResponse =
          await trafficService.getNavigationRoute(origin, destiny);

      if (trafficResponse != null && trafficResponse.code == 'Ok') {
        final geometry = trafficResponse.routes[0].geometry;
        final duration = trafficResponse.routes[0].duration;
        final distance = trafficResponse.routes[0].distance;

        // Decode an encoded string to a list of coordinates
        final polyline =
            Poly.Polyline.Decode(encodedString: geometry, precision: 6);
        final List<LatLng> points =
            polyline.decodedCoords.map((e) => LatLng(e[0], e[1])).toList();

        mapBloc.add(OnTraceDestinationRoute(
            points: points, distance: distance, duration: duration));

        Navigator.of(context).pop();

        final blocSearch = BlocProvider.of<SearchBloc>(context);
        blocSearch.add(OnFindManualLocation(false));
      }
    }
  }
}

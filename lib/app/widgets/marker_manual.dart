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

      // Obtener ruta
      final trafficResponse =
          await trafficService.getNavigationRoute(origin, destiny);

      // Obtener información del destino
      final reverseGeocodingResponse =
          await trafficService.getPlaceByCoordinates(destiny);

      if (trafficResponse != null &&
          trafficResponse.code == 'Ok' &&
          reverseGeocodingResponse != null &&
          reverseGeocodingResponse.features.isNotEmpty) {
        final geometry = trafficResponse.routes[0].geometry;
        final duration = trafficResponse.routes[0].duration;
        final distance = trafficResponse.routes[0].distance;
        //final destinyName = reverseGeocodingResponse.features[0].text;
        final destinyName = reverseGeocodingResponse.features[0].placeName;

        // Decode an enmocoded string to a list of coordinates
        final polyline =
            Poly.Polyline.Decode(encodedString: geometry, precision: 6);
        final List<LatLng> points =
            polyline.decodedCoords.map((e) => LatLng(e[0], e[1])).toList();

        // Disparar evento para trazar ruta.
        mapBloc.add(OnTraceDestinationRoute(
            points: points,
            distance: distance,
            duration: duration,
            destinyName: destinyName));

        Navigator.of(context).pop();

        final searchBloc = BlocProvider.of<SearchBloc>(context);
        searchBloc.add(OnFindManualLocation(false));

        // Agregar al historial
        final str = destinyName.split(',');
        final placeName = reverseGeocodingResponse.features[0].text;
        final placeDescription = '${str[2]}, ${str[3]}, ${str[4]}';
        final result = SearchResult(
            isSearchCanceled: false,
            isManualSearch: false,
            latLng: destiny,
            placeName: placeName,
            placeDescription: placeDescription);
        searchBloc.add(OnAddSearchToHistory(result));
      }
    }
  }
}

part of 'widgets.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isManualSearch) {
          return Container();
        }
        return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchbar(context));
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        child: GestureDetector(
          onTap: () async {
            final location = BlocProvider.of<MyLocationBloc>(context).state.lastLocation;
            final historical = BlocProvider.of<SearchBloc>(context).state.historical;

            if (location != null) {
              final result = await showSearch(context: context,
                  delegate: SearchDestination(location, historical));
              findResult(context, result!);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
            child: Text('¿Dónde quiere ir?'),
          ),
        ),
      ),
    );
  }

  Future<void> findResult(BuildContext context, SearchResult result) async {
    if (result.isSearchCanceled) return;

    if (result.isManualSearch) {
      final blocSearch = BlocProvider.of<SearchBloc>(context);
      blocSearch.add(OnFindManualLocation(true));
      return;
    }

    // TODO: Calcular ruta
    searchAlert(context);
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<MyLocationBloc>(context);

    final origin = locationBloc.state.lastLocation;
    final destiny = result.latLng;

    if (origin != null && destiny != null) {
      final trafficResponse =
          await trafficService.getNavigationRoute(origin, destiny);

      if (trafficResponse != null && trafficResponse.routes.isNotEmpty) {
        final geometry = trafficResponse.routes[0].geometry;
        final duration = trafficResponse.routes[0].duration;
        final distance = trafficResponse.routes[0].distance;

        final polyline =
            Poly.Polyline.Decode(encodedString: geometry, precision: 6);
        final List<LatLng> points =
            polyline.decodedCoords.map((e) => LatLng(e[0], e[1])).toList();

        mapBloc.add(OnTraceDestinationRoute(points: points, distance: distance, duration: duration));

        Navigator.of(context).pop();

        // Agregar al historial 
        final searchBloc = BlocProvider.of<SearchBloc>(context);
        searchBloc.add(OnAddSearchToHistory(result));
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_map/app/models/geocoding_response.dart';
import 'package:simple_map/app/models/search_result.dart';
import 'package:simple_map/app/services/traffic_service.dart';

/// Delegador para buscar destino
class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  final TrafficService _trafficService;
  final LatLng _proximity;
  final List<SearchResult> historical;

  SearchDestination(this._proximity, this.historical)
      : searchFieldLabel = 'Buscar',
        _trafficService = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, SearchResult(isSearchCanceled: true)),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _getResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Ubicar en el mapa'),
            subtitle: Text('Ajustar la ubicación manualmente en el mapa'),
            onTap: () {
              close(context,
                  SearchResult(isSearchCanceled: false, isManualSearch: true));
            },
          ),

          // Historial
          ...historical
              .map(
                (result) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text('${result.placeName}'),
                  subtitle: Text('${result.placeDescription}'),
                  onTap: () {
                    close(context, result);
                  },
                  ))
              .toList()
        ],
      );
    }

    return _getResults();
  }

  Widget _getResults() {
    if (query == 0) {
      return Container();
    }

    _trafficService.getSuggestionsByQuery(query.trim(), _proximity);

    return StreamBuilder(
      stream: _trafficService.suggestionsStream,
      builder:
          (BuildContext context, AsyncSnapshot<GeocodingResponse> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final places = snapshot.data!.features;

        if (places.isEmpty) {
          return ListTile(
            leading: Icon(Icons.not_listed_location_outlined),
            title: Text('No hay resultados con ( $query)'),
            subtitle: Text('Intenta con otro nombre'),
          );
        }

        return ListView.separated(
            separatorBuilder: (_, i) => Divider(),
            itemCount: places.length,
            itemBuilder: (_, i) {
              final place = places[i];

              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(place.text),
                subtitle: Text(place.placeName),
                onTap: () {
                  close(
                      context,
                      SearchResult(
                          isSearchCanceled: false,
                          isManualSearch: false,
                          latLng: LatLng(place.center[1], place.center[0]),
                          placeName: place.text,
                          placeDescription: place.placeName));
                },
              );
            });
      },
    );
  }
}

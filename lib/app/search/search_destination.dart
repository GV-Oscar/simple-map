import 'package:flutter/material.dart';
import 'package:simple_map/app/models/search_result.dart';

/// Delegador para buscar destino
class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  SearchDestination() : searchFieldLabel = 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () =>
            this.close(context, SearchResult(isSearchCanceled: true)),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Ubicar en el mapa'),
          subtitle: Text('Ajustar la ubicación manualmente en el mapa'),
          onTap: () {
            // TODO: Retornar resultado
            this.close(context,
                SearchResult(isSearchCanceled: false, isManualSearch: true));
          },
        )
      ],
    );
  }
}

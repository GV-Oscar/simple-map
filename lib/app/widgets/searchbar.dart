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
            final result = await showSearch(context: context, delegate: SearchDestination());
            findResult(context, result!);
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

  void findResult(BuildContext context, SearchResult result) {
    if (result.isSearchCanceled) return;

    if (result.isManualSearch) {
      final blocSearch = BlocProvider.of<SearchBloc>(context);
      blocSearch.add(OnFindManualLocation(true));
      return;
    }
  }
}

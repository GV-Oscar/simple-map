part of 'widgets.dart';

class BtnTrackUser extends StatelessWidget {
  // final void Function()? onPressed;
  const BtnTrackUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) => _createBtn(context, state),
    );
  }

  Widget _createBtn(BuildContext context, MapState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            onPressed: () {
              mapBloc.add(OnTrackingUser());
            },
            icon: state.isTrackingUser
                ? const Icon(
                    Icons.directions_run,
                    color: Colors.black87,
                  )
                : const Icon(
                    Icons.accessibility_new,
                    color: Colors.black87,
                  )),
      ),
    );
  }
}

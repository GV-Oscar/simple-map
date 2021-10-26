part of 'widgets.dart';

class BtnMyLocation extends StatelessWidget {
  final void Function()? onPressed;
  const BtnMyLocation({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.my_location,
              color: Colors.black87,
            )),
      ),
    );
  }
}

part of 'widgets.dart';

class BtnMyRoute extends StatelessWidget {
  final void Function()? onPressed;
  const BtnMyRoute({Key? key, this.onPressed}) : super(key: key);

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
              Icons.more_horiz,
              color: Colors.black87,
            )),
      ),
    );
  }
}

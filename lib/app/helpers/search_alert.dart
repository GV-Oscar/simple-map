part of 'helpers.dart';

void searchAlert(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Espere por favor'),
              content: Container(
                padding: EdgeInsets.only(top: 24,bottom: 24),
                child: Row(
                  children: [
                    Text('Calculado ruta'),
                    SizedBox(width: 16),
                    Container(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 1,
                        ))
                  ],
                ),
              ),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Espere por favor'),
              content: Row(
                children: [
                  Text('Calculado ruta'),
                  SizedBox(width: 16),
                  Container(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1,
                      ))
                ],
              ),
            ));
  }
}

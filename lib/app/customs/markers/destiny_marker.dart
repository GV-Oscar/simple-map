part of 'markers.dart';

class DestinyMarkerPainter extends CustomPainter {

  final String descripcion;
  final double mt;

  DestinyMarkerPainter({required this.descripcion, required this.mt});

  @override
  void paint(Canvas canvas, Size size) {
    final double circleB = 20;
    final double circleW = 7;

    Paint paint = Paint()..color = Colors.black;

    // Dibujar circulo negro
    canvas.drawCircle(Offset(circleB, size.height - circleB), circleB, paint);

    // Dibujar circulo blanco
    paint = Paint()..color = Colors.white;

    final cc = Rect.fromLTWH(15, size.height - 25, 10, 10);
    canvas.drawRect(cc, paint);

    //canvas.drawCircle(Offset(circleB, size.height - circleB), circleW, paint);

    // Dibujar sombra
    final Path path = new Path();

    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // Dibujar caja blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Dibujar caja negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 80, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar tiempo

    double km = mt / 1000;
    km = (km * 100).floorToDouble();
    km = (km / 100);

    TextSpan timeTitle = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),
        text: '$km'
    );

    TextPainter textPainter = TextPainter(
        text: timeTitle,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(5, 35));

    // Dibujar km
    TextSpan timeSubtitle = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: 'Km'
    );

    textPainter = TextPainter(
        text: timeSubtitle,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(5, 67));

     // Dibujar titulo
    TextSpan title = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        text: descripcion
    );

    textPainter = TextPainter(
        text: title,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 2,
        ellipsis: '...'
    )..layout(
      maxWidth: size.width - 105
    );

    textPainter.paint(canvas, Offset(90, 35));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
}
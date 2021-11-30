part of 'markers.dart';

class OriginMarkerPainter extends CustomPainter {

  final int duration;

  OriginMarkerPainter({required this.duration});

  @override
  void paint(Canvas canvas, Size size) {
    final double circleB = 20;
    final double circleW = 7;

    Paint paint = Paint()..color = Colors.black;

    // Dibujar circulo negro
    canvas.drawCircle(Offset(circleB, size.height - circleB), circleB, paint);
    
    // Dibujar circulo blanco
    paint = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(circleB, size.height - circleB), circleW, paint);

    // Dibujar sombra
    final Path path = new Path();

    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // Dibujar caja blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Dibujar caja negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar tiempo
    TextSpan timeTitle = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        text: '$duration'
    );

    TextPainter textPainter = TextPainter(
        text: timeTitle,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(40, 35));

    // Dibujar minutos
    TextSpan timeSubtitle = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: 'Min'
    );

    textPainter = TextPainter(
        text: timeSubtitle,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(40, 65));

     // Dibujar titulo
    TextSpan title = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        text: 'Mi ubicación'
    );

    textPainter = TextPainter(
        text: title,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width - 130
    );

    textPainter.paint(canvas, Offset(160, 50));



  }

  @override
  bool shouldRepaint(OriginMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(OriginMarkerPainter oldDelegate) => false;
}

part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerOriginIcon(int s) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final min = (s / 60).floor();

  final marker = OriginMarkerPainter(duration: min);
  marker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerDestinyIcon(
    String description, double distance) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final marker = DestinyMarkerPainter(descripcion: description, mt: distance);
  marker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

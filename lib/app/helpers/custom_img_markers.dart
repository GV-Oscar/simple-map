part of 'helpers.dart';
// Esta clase de ayuda permite dibujar markadores personalizados.

/// Obtener imagen de marcador a partir de un asset
Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        devicePixelRatio: 2.5,
      ),
      'assets/custom-pin.png');
}

/// Obtener imagen de marcador a partir de un asset
Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(responseType: ResponseType.bytes));

  // Obtener bytes de la imagen de internet
  final bytes = resp.data;
  // Cambiar resolucion de la imagen
  final imageCode = await instantiateImageCodec(bytes, targetHeight: 150, targetWidth: 150);
  final frame = await imageCode.getNextFrame();
  final data = await frame.image.toByteData(format: ImageByteFormat.png);

  if (data != null) {
    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
  return BitmapDescriptor.fromBytes(resp.data);
}

import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator?> paletteGenerator(
  ImageProvider image, {
  Size? size,
}) async {
  PaletteGenerator? paletteGenerator = await PaletteGenerator.fromImageProvider(
    image,
    size: size,
    // maximumColorCount: 8,
  );

  return paletteGenerator;
}

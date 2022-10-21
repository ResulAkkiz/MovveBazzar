import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

Future<List<PaletteGenerator?>> paletteGenerator(
  List<ImageProvider> images, {
  Size? size,
}) async {
  List<PaletteGenerator?> palette = [];

  for (ImageProvider image in images) {
    PaletteGenerator? paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      image,
      size: size,
      // maximumColorCount: 8,
    );
    palette.add(paletteGenerator);
  }

  return palette;
}

import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

typedef Palettes = List<PaletteGenerator?>;

Future<Palettes> paletteGenerator(
  List<ImageProvider> images, {
  Size? size,
}) async {
  Palettes palettes = [];

  try {
    for (ImageProvider image in images) {
      PaletteGenerator? paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        image,
        size: size,
        // maximumColorCount: 8,
      );
      palettes.add(paletteGenerator);
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return palettes;
}

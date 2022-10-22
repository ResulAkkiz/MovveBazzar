import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

typedef Palettes = List<PaletteGenerator?>;

Future<PaletteGenerator?> getPalette(
  ImageProvider image, {
  Size? size,
}) async {
  PaletteGenerator? paletteGenerator;

  try {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
      size: size,
      // maximumColorCount: 8,
    );
  } catch (e) {
    debugPrint(e.toString());
  }

  return paletteGenerator;
}

Future<Palettes> getPaletteFromList(
  List<ImageProvider> images, {
  Size? size,
}) async {
  Palettes palettes = [];

  for (ImageProvider image in images) {
    PaletteGenerator? paletteGenerator = await getPalette(
      image,
      size: size,
    );
    palettes.add(paletteGenerator);
  }

  return palettes;
}

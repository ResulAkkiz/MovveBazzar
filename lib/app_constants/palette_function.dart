import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';

typedef Palettes = List<PaletteGenerator?>;

extension PaletteColorsExtension on PaletteGenerator {
  PaletteColor? get primaryColor {
    bool isDominantMuted = dominantColor?.color == darkMutedColor?.color;

    return isDominantMuted ? darkVibrantColor : dominantColor;
  }
}

extension PaletteExtension on ImageProvider {
  Future<PaletteGenerator?> toPalette({
    Size? size,
  }) async {
    PaletteGenerator? paletteGenerator;

    try {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        this,
        size: size,
        // maximumColorCount: 8,
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return paletteGenerator;
  }
}

extension PaletteListExtension on List<ImageProvider> {
  Future<Palettes> toPalette({
    Size? size,
  }) async {
    Palettes palettes = [];

    for (ImageProvider image in this) {
      PaletteGenerator? paletteGenerator = await image.toPalette(
        size: size,
      );
      palettes.add(paletteGenerator);
    }

    return palettes;
  }
}

import 'package:flutter/rendering.dart';

class TicketClipper extends CustomClipper<Path> {
  final double notch;
  final double notchChange;
  final double radius;
  final double radiusRatio;
  final double? width;

  TicketClipper({
    this.notch = 0.36,
    this.notchChange = 0.01,
    this.radius = 36.0,
    this.radiusRatio = 0.15,
    this.width,
  });

  @override
  Path getClip(Size size) {
    double ratio = (1 / radiusRatio) - 1;
    double offset = notchChange * ratio;
    double sizeWidth = width ?? size.width;

    final Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(sizeWidth * (notch - offset - (notchChange * 2)), size.height)
      ..quadraticBezierTo(
          sizeWidth * (notch - offset - notchChange),
          size.height,
          sizeWidth * (notch - offset),
          size.height - (radius * radiusRatio))
      ..quadraticBezierTo(sizeWidth * notch, size.height - radius,
          sizeWidth * (notch + offset), size.height - (radius * radiusRatio))
      ..quadraticBezierTo(
          sizeWidth * (notch + offset + notchChange),
          size.height,
          sizeWidth * (notch + offset + (notchChange * 2)),
          size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(sizeWidth * (notch + offset + (notchChange * 2)), 0)
      ..quadraticBezierTo(sizeWidth * (notch + offset + notchChange), 0,
          sizeWidth * (notch + offset), (radius * radiusRatio))
      ..quadraticBezierTo(sizeWidth * notch, radius,
          sizeWidth * (notch - offset), (radius * radiusRatio))
      ..quadraticBezierTo(sizeWidth * (notch - offset - notchChange), 0,
          sizeWidth * (notch - offset - (notchChange * 2)), 0);

    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => true;
}

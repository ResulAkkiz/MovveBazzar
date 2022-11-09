import 'package:flutter/material.dart';
import 'dart:developer' as developer show log;

extension FlexExtension on Flex {
  separated(Widget separator) {
    final iterator = this.children.iterator;

    if (!iterator.moveNext()) return this;

    final children = <Widget>[];
    children.add(iterator.current);

    while (iterator.moveNext()) {
      children.add(separator);
      children.add(iterator.current);
    }

    if (direction == Axis.horizontal) {
      return Row(
        key: key,
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: children,
      );
    } else {
      return Column(
        key: key,
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: children,
      );
    }
  }
}

extension Log on Object {
  void log() => developer.log(toString());
}

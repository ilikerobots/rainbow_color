library rainbow_color;

import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:rainbow_vis/rainbow_vis.dart' as rbDart;

class Rainbow {
  final rbDart.Rainbow _rb;

  /// Construct a new Rainbow
  ///
  /// @param spectrum The list of color stops in the transitioning color range.
  /// @param rangeStart The beginning of the numerical domain to map.
  /// @param rangeEnd The end of the numerical domain to map.
  Rainbow(
      {Iterable<Color> spectrum = const [Color(0xFF000000), Color(0xFFFFFFFF)],
      rangeStart = 0.0,
      rangeEnd = 1.0})
      : _rb = rbDart.Rainbow(
            spectrum: spectrum.map(_colorToHex).toList(),
            rangeStart: rangeStart,
            rangeEnd: rangeEnd) {
    assert(spectrum.length >= 2);
    assert(rangeStart != rangeEnd);
    assert(rangeStart != null && rangeEnd != null);
  }

  /// the gradient definition
  List<Color> get spectrum => _rb.spectrum
      .map((h) => _hexToColor(h.substring(1)))
      .toList(growable: false);

  /// the range start
  num get rangeStart => _rb.rangeStart;

  /// the range end
  num get rangeEnd => _rb.rangeEnd;

  /// Return the interpolated color along the spectrum for domain item.
  /// If the number is outside the bounds of the domain, then the nearest
  /// edge color is returned.
  Color operator [](num number) => _colorAt(number);

  Color _colorAt(num number) {
    return _hexToColor(_rb[number]);
  }

  static String _colorToHex(Color c) {
    return "#${(c.value & 0xFFFFFFFF).toRadixString(16).padLeft(8, '0').toUpperCase()}";
  }

  static Color _hexToColor(String h) {
    return Color(int.parse(h, radix: 16));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rainbow && runtimeType == other.runtimeType && _rb == other._rb;

  @override
  int get hashCode => _rb.hashCode;
}

/// An interpolation between two or more colors.
///
/// This class specializes the interpolation of [Rainbow] to use
/// [Color.lerp].
///
/// See [Tween] for a discussion on how to use interpolation objects.
class RainbowColorTween extends Tween<Color> {
  final Rainbow _rb;

  /// Creates a [Color] tween.
  RainbowColorTween(List<Color> spectrum)
      : _rb = Rainbow(spectrum: spectrum, rangeStart: 0.0, rangeEnd: 1.0),
        super(begin: spectrum.first, end: spectrum.last);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Color lerp(double t) => _rb[t];
}

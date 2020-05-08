import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:rainbow_color/rainbow_color.dart';

// ignore: type_annotate_public_apis
main() {
  group('Rainbow basic features', () {
    setUp(() {});

    test('Default Spectrum', () {
      var rb = Rainbow();
      expect(rb[00.00], Color(0xff000000));
      expect(rb[0.333333], Color(0xff555555));
      expect(rb[0.666667], Color(0xffaaaaaa));
      expect(rb[1.0], Color(0xffffffff));
    });

    test('Ascending domain', () {
      var rb = Rainbow(
          spectrum: [Color(0xFF0000), Color(0xFFFFFF), Color(0xff00ff00)],
          rangeStart: -0.5,
          rangeEnd: 0.5);
      expect(rb[-5.0], Color(0xffff0000));
      expect(rb[-1.0], Color(0xffff0000));
      expect(rb[-0.50], Color(0xffff0000));
      expect(rb[-0.25], Color(0xffff8080));
      expect(rb[-0], Color(0xffffffff));
      expect(rb[0], Color(0xffffffff));
      expect(rb[0.33], Color(0xff57ff57));
      expect(rb[0.5], Color(0xff00ff00));
      expect(rb[1.0], Color(0xff00ff00));
      expect(rb[5.0], Color(0xff00ff00));
    });

    test('Descending Domain', () {
      var rb = Rainbow(
          spectrum: [Color(0xFF0000), Color(0xFFFFFF), Color(0xff00ff00)],
          rangeStart: 0.5,
          rangeEnd: -0.5);
      expect(rb[-5.0], Color(0xff00ff00));
      expect(rb[-1.0], Color(0xff00ff00));
      expect(rb[-0.50], Color(0xff00ff00));
      expect(rb[-0.33], Color(0xff57ff57));
      expect(rb[-0], Color(0xffffffff));
      expect(rb[0], Color(0xffffffff));
      expect(rb[0.25], Color(0xffff8080));
      expect(rb[0.5], Color(0xffff0000));
      expect(rb[1.0], Color(0xffff0000));
      expect(rb[5.0], Color(0xffff0000));
    });

    test('Ascending/Descending matches', () {
      var spec = [
        Color(0xffff0000),
        Color(0xff215608),
        Color(0xff99AA54),
        Color(0xff0000ff),
        Color(0xffcf3810)
      ];
      var rbu = Rainbow(spectrum: spec, rangeStart: 100.0, rangeEnd: -50.0);
      var rbd = Rainbow(spectrum: spec, rangeStart: -50.0, rangeEnd: 100.0);
      for (var u = -50.0, d = 100.0; u <= 100.0; u += 1.0, d -= 1) {
        expect(rbu[u], rbd[d]);
      }
    });
  });
//
  group('Getters', () {
    setUp(() {});
    test('Get spectrum', () {
      var spec = const [
        Color(0xffFF0000),
        Color(0xffFFFFFF),
        Color(0xff00ff00)
      ];
      var rb = Rainbow(spectrum: spec, rangeStart: 20, rangeEnd: 50);
      expect(rb.spectrum, spec);
    });
    test('Get range', () {
      var rS = -32.0;
      var rE = 101.320;
      var rb = Rainbow(
          spectrum: const [Color(0xFF0000ff), Color(0xFF00FF00)],
          rangeStart: rS,
          rangeEnd: rE);
      expect(rb.rangeStart, rS);
      expect(rb.rangeEnd, rE);
    });
  });
  group('Equals', () {
    var spec = [Color(0xFF0000), Color(0xFFFFFF), Color(0xff00ff00)];

    test('Is Equal', () {
      expect(
          Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5) ==
              Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5),
          true);
    });
    test('Is Not Equal', () {
      expect(
          Rainbow(spectrum: spec, rangeStart: -0.1, rangeEnd: 0.5) ==
              Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5),
          false);
      expect(
          Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5) ==
              Rainbow(spectrum: spec, rangeStart: 0.5, rangeEnd: -0.5),
          false);
      expect(
          Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 9.5) ==
              Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5),
          false);
      expect(
          Rainbow(
                  spectrum: const [Color(0xFF00FF00), Color(0xFF0000FF)],
                  rangeStart: -0.5,
                  rangeEnd: 0.5) ==
              Rainbow(spectrum: spec, rangeStart: -0.5, rangeEnd: 0.5),
          false);
    });
  });

  group('Constructor assertions', () {
    setUp(() {});

    test('Invalid ranges', () {
      expect(() => Rainbow(rangeStart: 100, rangeEnd: 100),
          throwsA(isA<AssertionError>()));
      expect(() => Rainbow(rangeStart: -1, rangeEnd: -1),
          throwsA(isA<AssertionError>()));
      expect(() => Rainbow(rangeStart: 1), throwsA(isA<AssertionError>()));
      expect(() => Rainbow(rangeStart: null, rangeEnd: 23.0),
          throwsA(isA<AssertionError>()));
      expect(() => Rainbow(rangeStart: -10, rangeEnd: null),
          throwsA(isA<AssertionError>()));
    });
  });
}

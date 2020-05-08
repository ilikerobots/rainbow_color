# rainbow_color

[![Pub](https://img.shields.io/pub/v/rainbow_color.svg?maxAge=2592000?style=flat-square)](https://pub.dartlang.org/packages/rainbow_color)
[![Travis](https://img.shields.io/travis/ilikerobots/rainbow_color.svg?maxAge=2592000?style=flat-square)](https://travis-ci.org/ilikerobots/rainbow_color)


Color interpolation; Map a numerical domain to a smooth-transitioning color range.

This is a Flutter-oriented version of the Dart package [rainbow_vis](https://pub.dev/packages/rainbow_vis).  

## Usage

To interpolate a color among the spectrum, use the list access operator, e.g.
```dart
var rb = Rainbow(spectrum: [Color(0xFF0000), Color(0xFFFFFF), Color(0xff00ff00)],
                 rangeStart: -10,
                 rangeEnd: 10);
Color myColdColor = rb0[-9.32];
Color myWarmColor = rb0[8.44];
```



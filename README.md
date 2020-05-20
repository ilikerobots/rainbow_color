# rainbow_color

[![Pub](https://img.shields.io/pub/v/rainbow_color.svg?maxAge=2592000?style=flat-square)](https://pub.dartlang.org/packages/rainbow_color)
[![Travis](https://img.shields.io/travis/ilikerobots/rainbow_color.svg?maxAge=2592000?style=flat-square)](https://travis-ci.org/ilikerobots/rainbow_color)


RainbowColor simplifies interpolation a numerical domain onto a multi-color range.  RainbowColor accepts a numerical domain 
(i.e. a start and end number) and a spectrum of two or more colors, and offers the list access operator (`[]`) for
interpolation.

This package also provides `RainbowColorTween`, a multi-color variant of the standard ColorTween, eliminating the need
to build more complex `TweenSequence` for equal-weight transitions.

<img src="https://github.com/ilikerobots/rainbow_color/raw/master/doc/assets/rainbow_color_example.gif" width="256">


## Usage

To interpolate a color among the spectrum, use the list access operator, e.g.
```dart
import 'package:rainbow_color/rainbow_color.dart';

var rb = Rainbow(spectrum: [Color(0xFFFF0000), Color(0xFFFFFFFF), Color(0xff00ff00)],
                 rangeStart: -10,
                 rangeEnd: 10);
Color warmColor = rb[-9.32];
Color coldColor = rb[8.44];
```

Or use `RainbowColorTween` in place of `ColorTween` to interpolate among multiple colors instead of two.

```dart
@override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _clAnim = RainbowColorTween([Color(0x33FFAAAA),
                                 Color(0x33000000),
                                 Color(0x00000000)]).animate(_controller)
                                                    ..addListener(() { 
                                                         setState(() {}); 
                                                    });
}
```


## See Also

This is a Flutter-oriented version of the vanilla Dart package [rainbow_vis](https://pub.dev/packages/rainbow_vis).  

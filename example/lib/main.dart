import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Rainbow Color Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColorCycler(),
          ],
        ),
      ),
    );
  }
}

class ColorCycler extends StatefulWidget {
  ColorCycler({
    Key key,
  }) : super(key: key);

  @override
  _ColorCyclerState createState() => _ColorCyclerState();
}

class _ColorCyclerState extends State<ColorCycler>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  final Rainbow _rb = Rainbow(spectrum: const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
  ], rangeStart: 0.0, rangeEnd: 300.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, _) => Column(
          children: <Widget>[
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _rb[animation.value],
                      _rb[(50.0 + animation.value) % _rb.rangeEnd]
                    ]),
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GreyScaleCycler(
                        baseColor: _rb[animation.value],
                        duration: const Duration(seconds: 5),
                        text: "Foo"),
                    GreyScaleCycler(
                        baseColor: _rb[(50.0 + animation.value) % _rb.rangeEnd],
                        duration: const Duration(seconds: 8),
                        text: "Bar",
                        leftToRight: false),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Container(
                height: 50.0,
                child: new Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(10, (index) => index / 10)
                          .map((s) => Container(
                              height: 45.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Rainbow(spectrum: [
                                        _rb[animation.value],
                                        _rb[(50.0 + animation.value) %
                                            _rb.rangeEnd]
                                      ])[s],
                                      Color(0xffffff)
                                    ]),
                              )))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    animation = Tween<double>(begin: _rb.rangeStart, end: _rb.rangeEnd)
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reset();
              controller.forward();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GreyScaleCycler extends StatefulWidget {
  const GreyScaleCycler({
    Key key,
    @required this.baseColor,
    @required this.text,
    @required this.duration,
    this.leftToRight = true,
  }) : super(key: key);

  final Color baseColor;
  final Duration duration;
  final bool leftToRight;
  final String text;

  static const List<Color> spectrum = [
    Colors.white,
    const Color(0x33ffffff),
    const Color(0x33000000),
    Colors.black,
    const Color(0x33000000),
    const Color(0x33ffffff),
    Colors.white
  ];

  @override
  _GreyScaleCyclerState createState() => _GreyScaleCyclerState();
}

class _GreyScaleCyclerState extends State<GreyScaleCycler>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> _bwAnim;
  Animation<Color> _wbAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    _wbAnim = RainbowColorTween(GreyScaleCycler.spectrum).animate(controller);
    _bwAnim = RainbowColorTween(GreyScaleCycler.spectrum).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.baseColor, _bwAnim.value],
          begin:
              widget.leftToRight ? Alignment.centerLeft : Alignment.centerRight,
          end:
              widget.leftToRight ? Alignment.centerRight : Alignment.centerLeft,
        ),
        border: Border.all(
          color: Colors.black87,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(color: _wbAnim.value, fontSize: 24.0)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

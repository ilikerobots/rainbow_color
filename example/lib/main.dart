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
  const ColorCycler({
    Key key,
  }) : super(key: key);

  @override
  _ColorCyclerState createState() => _ColorCyclerState();
}

class _ColorCyclerState extends State<ColorCycler>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  static List<Color> mainSpectrum = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red
  ];
  static List<Color> secondarySpectrum = [
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
    Colors.orange
  ];
  Rainbow rbMain =
      Rainbow(spectrum: mainSpectrum, rangeStart: 0.0, rangeEnd: 300.0);
  Rainbow rbInvert =
      Rainbow(spectrum: secondarySpectrum, rangeStart: 0.0, rangeEnd: 300.0);
  Rainbow rbGreyscale = Rainbow(
      spectrum: [Colors.black, Colors.white, Colors.black],
      rangeStart: 0.0,
      rangeEnd: 300.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250.0,
        decoration: BoxDecoration(
//          color: rb[animation.value],
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [rbMain[animation.value], rbInvert[animation.value]]),
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
//          Padding(
//            padding: const EdgeInsets.all(5.0),
//            child: Text("Far out!",
//                style: TextStyle(
//                    color: textRb[.85].withOpacity(0.85), fontSize: 24.0)),
//          ),
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        rbMain[animation.value],
                        rbGreyscale[
                            ((rbGreyscale.rangeEnd / 2) + animation.value) %
                                rbGreyscale.rangeEnd]
                      ]),
                  border: Border.all(
                    color: Colors.black87,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("Foo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: rbGreyscale[animation.value],
                            fontSize: 24.0)),
                  ),
                ),
              ),
              Container(
                height: 55.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        rbInvert[animation.value],
                        rbGreyscale[animation.value]
                      ]),
                  border: Border.all(
                    color: Colors.black87,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("Bar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: rbGreyscale[
                                ((rbGreyscale.rangeEnd / 2) + animation.value) %
                                    rbGreyscale.rangeEnd],
                            fontSize: 24.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: rbMain.rangeStart, end: rbMain.rangeEnd)
        .animate(controller)
          ..addListener(() {
            setState(() {
              // The state that has changed here is the animation object’s value.
            });
          })
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

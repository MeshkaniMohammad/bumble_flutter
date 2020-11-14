import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dander',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dander'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _arcTween;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController.unbounded(vsync: this, duration: Duration(seconds: 2));
    _arcTween = MaterialPointArcTween(begin: Offset(0, 0), end: Offset(2, 300))
        .animate(_animationController);
    //_animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.amber[100],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 40,
            left: 100,
            child: FlatButton(
              child: Text("press me!"),
              onPressed: () {
                _animationController.forward();
              },
            ),
          ),
          Transform.translate(
            offset: _arcTween.value,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

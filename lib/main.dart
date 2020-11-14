import 'package:bumble_flutter/swipeable-card-example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dander',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.amber[100],
      body: SwipeableCardExample(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: " "),
          BottomNavigationBarItem(icon: Icon(Icons.messenger_rounded), label: " "),
        ],
      ),
    );
  }
}

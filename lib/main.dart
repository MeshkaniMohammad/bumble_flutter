import 'dart:math';

import 'package:bumble_flutter/action_circles.dart';
import 'package:bumble_flutter/swipe_controller.dart';
import 'package:bumble_flutter/swipeable-card-example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bumble',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'bumble'),
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
    return ChangeNotifierProvider(
      create: (context) => SwipeController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Transform.rotate(
              angle: pi / 2,
              child: Icon(
                Icons.settings_input_component_rounded,
                size: 40,
                color: Colors.black12,
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          title: Text(
            widget.title,
            style: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.amberAccent,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomNavigationIcon(
                    color: Colors.black12,
                    iconData: CupertinoIcons.person_fill,
                  ),
                  BottomNavigationIcon(
                    iconData: CupertinoIcons.text_aligncenter,
                    color: Colors.black87,
                  ),
                  BottomNavigationIcon(
                    color: Colors.black12,
                    iconData: CupertinoIcons.chat_bubble_fill,
                  ),
                ],
              ),
            ),
            SwipeableCardExample(),
            ActionCircles(),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const BottomNavigationIcon({Key key, this.iconData, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: color,
          size: 40,
        ),
        SizedBox(
          height: 35,
        )
      ],
    );
  }
}

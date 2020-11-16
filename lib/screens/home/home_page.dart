import 'dart:math';

import 'package:bumble_flutter/widgets/bottom_navigation_bar_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/swipe_controller.dart';
import '../../widgets/action_circles.dart';
import 'home_page_body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                fontSize: 30, color: Colors.amberAccent, fontWeight: FontWeight.w600),
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
            HomePageBody(),
            ActionCircles(),
          ],
        ),
      ),
    );
  }
}

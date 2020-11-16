import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/card_contents.dart';
import '../../widgets/bumble_card.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody({Key key}) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<int> cards = [2, 1];
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  Widget _getCardContents(CardContents contents) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(contents.imageUrl,
                            height: MediaQuery.of(context).size.height - 200,
                            width: constraints.maxWidth,
                            fit: BoxFit.cover),
                        Positioned(
                          bottom: 20,
                          left: 15,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 8.0),
                            child: RichText(
                              text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
                                TextSpan(
                                    text: contents.name,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ", ${contents.age}",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ]),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Chip(
                            label: Text(
                              "bff",
                              style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 80,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.format_quote,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        contents.description,
                        style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.white,
                            size: 12,
                          ),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${contents.name}\'s location",
                          style: GoogleFonts.montserrat(fontSize: 17, color: Colors.black54),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(contents.location,
                          style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black54)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          width: 70,
                          height: 70,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, color: Colors.amberAccent),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Block & Report",
                          style: GoogleFonts.montserrat(
                              fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                          width: 70,
                          height: 70,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, color: Colors.amberAccent),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Function _prepareFutureCards(int x) {
    return () {
      setState(() {
        if (!cards.contains(x + 1)) {
          cards.insert(0, x + 1);
        }
        if (!cards.contains(x + 2)) {
          cards.insert(0, x + 2);
        }
      });
    };
  }

  Function _removeCard(int x) {
    return () {
      setState(() {
        if (cards.contains(x)) {
          cards.remove(x);
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      width: MediaQuery.of(context).size.width,
      child: Stack(
          children: cards
              .map((int x) => BumbleCard(
                    key: Key("$x"),
                    child: _getCardContents(CARDS[x % CARDS.length]),
                    onDragStart: _prepareFutureCards(x),
                    onCardOffscreen: _removeCard(x),
                  ))
              .toList()),
    );
  }
}

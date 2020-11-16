import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'swipeable-card.dart';

List<CardContents> CARDS = [
  CardContents()
    ..name = "Nilofar"
    ..age = "22"
    ..imageUrl =
        "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"
    ..fruitDescription = "Way better than Apples",
  CardContents()
    ..name = "Jasmin"
    ..age = "26"
    ..imageUrl =
        "https://images.unsplash.com/photo-1504703395950-b89145a5425b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1302&q=80"
    ..fruitDescription = "Way better than Apples",
  CardContents()
    ..name = "Amir"
    ..age = "34"
    ..imageUrl =
        "https://images.unsplash.com/photo-1496345875659-11f7dd282d1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
    ..fruitDescription = "Way better than Apples",
  CardContents()
    ..name = "Dan"
    ..age = "24"
    ..imageUrl =
        "https://images.unsplash.com/photo-1488161628813-04466f872be2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80"
    ..fruitDescription = "Way better than Apples",
  CardContents()
    ..name = "John"
    ..age = "31"
    ..imageUrl =
        "https://images.unsplash.com/photo-1492446845049-9c50cc313f00?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"
    ..fruitDescription = "Way better than Apples",
  CardContents()
    ..name = "Parmin"
    ..age = "21"
    ..imageUrl =
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80"
    ..fruitDescription = "Way better than Apples",
];

class SwipeableCardExample extends StatefulWidget {
  SwipeableCardExample({Key key}) : super(key: key);

  @override
  _SwipeableCardExampleState createState() => _SwipeableCardExampleState();
}

class _SwipeableCardExampleState extends State<SwipeableCardExample> {
  List<int> cards = [2, 1];
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  Widget _getCardContents(CardContents contents) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView(
        addRepaintBoundaries: false,
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(contents.imageUrl,
                  height: constraints.maxWidth, width: constraints.maxWidth, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 8.0),
                child: RichText(
                  text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
                    TextSpan(
                        text: contents.name,
                        style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w500)),
                    TextSpan(text: ", ${contents.age}", style: GoogleFonts.montserrat(fontSize: 30))
                  ]),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(contents.imageUrl,
                  height: constraints.maxWidth, width: constraints.maxWidth, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 8.0),
                child: RichText(
                  text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
                    TextSpan(
                        text: contents.name,
                        style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w500)),
                    TextSpan(text: ", ${contents.age}", style: GoogleFonts.montserrat(fontSize: 30))
                  ]),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(contents.imageUrl,
                  height: constraints.maxWidth, width: constraints.maxWidth, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 8.0, 5, 8.0),
                child: RichText(
                  text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
                    TextSpan(
                        text: contents.name,
                        style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w500)),
                    TextSpan(text: ", ${contents.age}", style: GoogleFonts.montserrat(fontSize: 30))
                  ]),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
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
              .map((int x) => SwipeableCard(
                    key: Key("$x"),
                    child: _getCardContents(CARDS[x % CARDS.length]),
                    onDragStart: _prepareFutureCards(x),
                    onCardOffscreen: _removeCard(x),
                  ))
              .toList()),
    );
  }
}

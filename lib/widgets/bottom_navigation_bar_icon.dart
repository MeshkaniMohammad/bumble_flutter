import "package:flutter/material.dart";

class BottomNavigationIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const BottomNavigationIcon({Key key, this.iconData, this.color}) : super(key: key);
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

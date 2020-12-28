import 'package:flutter/material.dart';

class CustomBottombar extends StatelessWidget {

  final List<Icon> icons;
  final int selectedIndex;
  final Function(int) onTap;
  //final bool isBottomIndicator;

  const CustomBottombar({
    Key key,
    @required this.selectedIndex,
    @required this.icons,
    @required this.onTap,
    //this.isBottomIndicator = false,
  }) : super(key: key);


    @override
    Widget build(BuildContext context) {
return BottomAppBar(
shape: CircularNotchedRectangle(),
child: new Row(
mainAxisSize: MainAxisSize.max,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: <Widget>[
IconButton(icon: icons[selectedIndex], onPressed: () {}, tooltip: "sara",),
IconButton(icon: Icon(Icons.search), onPressed: () {},),
],
),
);
    }
}

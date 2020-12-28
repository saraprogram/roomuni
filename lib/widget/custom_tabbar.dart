import 'package:flutter/material.dart';
import 'package:roomie/config/palette.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const CustomTabBar({
    Key key,
    @required this.icons,
    @required this.labels,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(

      labelStyle: TextStyle(fontSize:12.0),
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
          bottom: BorderSide(
            color: Palette.facebookBlue,
            width: 3.0,
          ),
        )
            : Border(
          top: BorderSide(
            color: Palette.facebookBlue,
            width: 3.0,
          ),
        ),
      ),
      labelColor: Colors.black38,
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
        i,
        Tab(
          icon: Icon(
            e,
            color: i == selectedIndex
                ? Palette.facebookBlue
                : Colors.black45,
            size: 25.0,
          ),
          text: labels[i],

        ),
      ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}

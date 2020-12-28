import 'package:flutter/material.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatelessWidget {
  //final User currentUser;
  //final List<IconData> icons;
  //final int selectedIndex;
  //final Function(int) onTap;
  final String title;

  const CustomAppBar({
    Key key,
    //@required this.currentUser,
    //@required this.icons,
    //@required this.selectedIndex,
    //@required this.onTap,
    @required this.title,
  }) : super(key: key);

  /*

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'roomie',
              style: const TextStyle(
                color: Palette.facebookBlue,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //UserCard(user: currentUser),
                const SizedBox(width: 12.0),
                CircleButton(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () => print('Search'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 */

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 1),
        child:Text(title,style: const TextStyle(
          color: Palette.facebookBlue,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2,
        ),),
      ),
      actions: [
        CircleButton(
          icon: Icons.search,
          iconSize: 30.0,
          onPressed: () => print('Search'),
        ),
      ],
    );

  }

}

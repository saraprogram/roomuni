import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/FAB.dart';
import 'package:roomie/screen/ImagePicker.dart';
import 'package:roomie/screen/dragable.dart';
import 'package:roomie/screen/email.dart';
import 'package:roomie/screen/image.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/screen/slideup.dart';
import 'package:roomie/screen/stateless_que.dart';
import 'package:roomie/screen/test.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    AdsRoom(),
    QuestionRoom(),
    CustomImagePicker1(),
    MyList(),
    SettingRoom(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.question_answer,
    MdiIcons.school,
    MdiIcons.accountCircleOutline,
    Icons.menu,
  ];

  final List<String> _labels = const [
    "Home",
    "Question",
    "test",
    "My List",
    "Profile",
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    //----------------------------------

    //------------------------------------

    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar:

        Container(
          height: 60,
          padding: const EdgeInsets.only(bottom: 2.0),
          color: Colors.white,
          child: CustomTabBar(
            icons: _icons,
            labels: _labels,
            selectedIndex: _selectedIndex,
            onTap:  (index) => setState(() => _selectedIndex = index),
          ),
        )

      ),
    );

  }
}

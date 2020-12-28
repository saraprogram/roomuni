import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/screen/image.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/screen/slideup.dart';
import 'package:roomie/screen/test.dart';
import 'package:roomie/widget/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomeRoom(),
    imageShape(),
    //MainCollapsingToolbar(),
    slideUp(),
    MainCollapsingToolbar(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeRoom(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: AnimatedAddButton(name: 'advertise',),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomeRoom(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.cyan : Colors.grey,
                          size: 25,
                        ),
                        Text(
                          'Ads',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.cyan : Colors.grey,
                            fontWeight: FontWeight.bold,fontSize: 12,

                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            imageShape();// if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.question_answer,
                          color: currentTab == 1 ? Colors.cyan : Colors.grey,
                          size: 25,
                        ),
                        Text(
                          'Question',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.cyan : Colors.grey,
                            fontWeight: FontWeight.bold,fontSize: 12,

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            slideUp(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MdiIcons.accountCircleOutline,
                          color: currentTab == 2 ? Colors.cyan : Colors.grey,
                          size: 25,
                        ),
                        Text(
                          'My List',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.cyan : Colors.grey,
                            fontWeight: FontWeight.bold,fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MainCollapsingToolbar(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.menu,
                          color: currentTab == 3 ? Colors.cyan : Colors.grey,
                          size: 25,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.cyan : Colors.grey,
                            fontWeight: FontWeight.bold,fontSize: 12,

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

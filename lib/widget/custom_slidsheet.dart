import 'package:flutter/material.dart';

class CustomSheet extends StatefulWidget {
  @override
  _CustomSheetState createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {

  void slideSheet() {
    showModalBottomSheet(
      context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Row1')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Row2')
                    ],
                  )


                ],
              ),
            ),
          );
        });
  }






  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

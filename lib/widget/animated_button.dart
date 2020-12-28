import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/screen/ads_add.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/widget/widgets.dart';

class AnimatedAddButton extends StatefulWidget {
  final String name;
  final String hero;

  const   AnimatedAddButton({
    @required this.name,
    @required this.hero,

  }) ;


  @override
  _AnimatedAddButtonState createState() => _AnimatedAddButtonState();

}

class _AnimatedAddButtonState extends State<AnimatedAddButton> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          if (widget.name == 'question'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestion(),
              ),
            );
          }
          else if(widget.name == 'advertise'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAdvertise(),
              ),
            );
          }
          else {
            return Container();
          }

        }, //onPressed,
        tooltip: 'Add',
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
        heroTag: widget.hero,
      ),
    );
  }
}

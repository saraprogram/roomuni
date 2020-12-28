
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class slideUp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("SlidingUpPanelExample"),
          ),
          body: Stack(
            children: <Widget>[
              Center(child: Text("This is the Widget behind the sliding panel"),),

              SlidingUpPanel(
                minHeight: 70,
                maxHeight: MediaQuery.of(context).size.height / 2,
                backdropEnabled: true,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                //color: Colors.transparent,
                collapsed: Container(
                child: Container(
      height: 70,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
      Container(
      //first container
      height: 20,
      width: 60,
      child: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
      color: Colors.red,
      onPressed: () {},
      shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0))),
      ),
      ),
        Container(
          //second container
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: ListTile(
            onTap: () {},
            title: Text(
              'Cart: ',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Text("Total( " + " :sum)"),
          ),
        )
      ]),
                ),
                ),
                panel: Center(child: Text("This is the sliding Widget"),),
              )
            ],
          )
      );
    }  }



import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class Adsdetails extends StatelessWidget {

  double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //automaticallyImplyLeading: false,
      ),

      /*
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () {},tooltip: "sara",),
            IconButton(icon: Icon(Icons.search), onPressed: () {},tooltip: "test",),
          ],
        ),
      ),
      */
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: new Stack(
                children: <Widget>[
                  _buildIamge(context),
                  _buildProfileRow(context),
                  //_buildTopHeader(),
                  //_mainDisplay(context),
                  _buildBottomPart(context),

                ],
              ),
            ),
          ),
          _contactBar(context),
        ],
      ),
    );
  }
}

Widget _buildIamge( context) {
  return new ClipPath(
    clipper: new DialogonalClipper(),
    child: new Image.asset(
      'assets/ava.jpg',
      fit: BoxFit.fitWidth,
      height: 400.0,
      width: MediaQuery.of(context).size.width,
      colorBlendMode: BlendMode.srcOver,
      //color: new Color.fromARGB(120, 20, 10, 40),
    ),
  );
}


Widget _mainDisplay( context) {
  final Ads toads = ModalRoute.of(context).settings.arguments;
  return new Center(
      child:Container(
        padding: EdgeInsets.only(top:250),
        child: Text(toads.description),
      )
  );
}


Widget _buildProfileRow(context) {
  double _imageHeight = 256.0;
  final Ads toads = ModalRoute.of(context).settings.arguments;

  return new Padding(
    padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2),
    child: new Row(
      children: <Widget>[
        new CircleAvatar(
          minRadius: 28.0,
          maxRadius: 28.0,
          backgroundImage: new AssetImage('assets/images/as.png'),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Icon(MdiIcons.tag , size: 30,color: Colors.black45,),
                  new Text(
                    " ${toads.tag}",
                    style: new TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              new Text(
                "Created by: ${toads.userName}",
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget _buildBottomPart(context) {
  double _imageHeight = 256.0;

  return new Padding(
    padding: new EdgeInsets.only(top: _imageHeight * 1.4),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAdHeader(context),
        _buildAdDetail(context),
      ],
    ),
  );
}


Widget _buildAdHeader(context) {
  final Ads toads = ModalRoute.of(context).settings.arguments;

  return new Padding(
    padding: new EdgeInsets.only(left: 20.0 , bottom: 30.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          toads.title,
          style: new TextStyle(fontSize: 30.0),
        ),
        new Text(
          toads.city,
          style: new TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
      ],
    ),
  );
}


Widget _buildAdDetail(context) {
  final Ads toads = ModalRoute.of(context).settings.arguments;
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'sara.sabounchi@gmail.com',
      queryParameters: {
        'subject': 'Example Subject & Symbols are allowed!'
      }
  );

  return Padding(
    padding: new EdgeInsets.only(left: 20.0 , right: 20.0),
    child: new Column(
      children: [
        Container(child:Text(
          toads.description,
          style: TextStyle(fontSize: 15,height: 1.2),
         // style: new TextStyle(color: Colors.black, fontSize: 16 , height: 1.25, ),
        ),),
        Padding(padding: EdgeInsets.only(bottom: 10),),
        Divider(color: Colors.black45,height: 20,thickness: 3),
        Container(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contact Information :",
                style: new TextStyle( fontSize: 14.0,fontWeight: FontWeight.bold),
              ),
            ],
          ),),

        Container(
          padding: EdgeInsets.only(top:20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "whatsapp number",
                style: new TextStyle(fontSize: 14.0),
              ),
              Text(
                toads.whatsApp,
                style: new TextStyle(fontSize: 14.0),
              ),
            ],
          ),),
        //Divider(color: Colors.black45,height: 20,thickness: 3),
        Container(
          padding: EdgeInsets.only(top:20,bottom: 30),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "email address",
                style: new TextStyle(fontSize: 14.0),
              ),
              Text(
                toads.email,
                style: new TextStyle(fontSize: 14.0),
              ),
            ],
          ),),
      ],
    ),
  );
}


Widget _contactBar(context){

  final Ads toads = ModalRoute.of(context).settings.arguments;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1),
      color: Colors.deepOrange,
    ),

    //color: Colors.white30,
    height: 50,
    child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        Container(
            width: MediaQuery.of(context).size.width/2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),

            ),
            child: new IconButton(
              alignment:Alignment.center,icon: Icon(MdiIcons.email),iconSize: 30 ,color: Colors.blue,
              onPressed:() {
                FlutterOpenWhatsapp.sendSingleMessage(toads.whatsApp, "Hello");
              },
            )
        ),
        Container(
            width: MediaQuery.of(context).size.width/2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),

            ),
            child: new IconButton(
              alignment:Alignment.center,icon: Icon(MdiIcons.whatsapp),iconSize: 30 ,color: Colors.green,
              onPressed:() {
                FlutterOpenWhatsapp.sendSingleMessage(toads.whatsApp, "Hello");
              },
            )
        ),

      ],
    ),
  );

}


//**********************************
class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 100.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
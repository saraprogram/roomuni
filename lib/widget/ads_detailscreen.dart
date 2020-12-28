import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/widget/widgets.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Ads toads = ModalRoute.of(context).settings.arguments;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(toads.userName),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AdsText( text:toads.description,fontSize:14.0,fontWeight: FontWeight.normal,colors: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PostStats(model: toads , type: 'ads',),
            ),
          ],
        ),
      ),
    );
  }
}
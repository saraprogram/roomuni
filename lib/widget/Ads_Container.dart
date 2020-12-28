import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/config/palette.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/screen/image.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:flutter/foundation.dart';


class AdsContainer extends StatelessWidget {
  final Ads ads;

  const AdsContainer({
    Key key,
    @required this.ads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final ThemeData theme = Theme.of(context);
    final TextStyle descriptionStyle = theme.textTheme.subtitle1;

    //final bool isDesktop = Responsive.isDesktop(context);
    return new GestureDetector( //You need to make my child interactive
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Adsdetails(),
            settings: RouteSettings(
              arguments: ads,
            ),
          ),
        );
      },
      child:Container(
        child: new Card(
          margin: EdgeInsets.only(left: 0, right: 0, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:[
                  Container(padding: EdgeInsets.all(16),
                      height: 70,
                      width: 70,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: ads.userName == 'ali' ? Image.asset(
                            'assets/images/as.png',
                            fit: BoxFit.fill,
                          ) : Image.asset(
                            'assets/icon.png',
                            fit: BoxFit.fill,
                          )
                      )
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child:
                          AdsText( text:ads.title,fontSize:16.0,fontWeight: FontWeight.bold,colors: Colors.black54),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child:
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(MdiIcons.tag , size: 20,color: Colors.blueGrey,),
                              AdsText( text:"  ${ads.tag}",fontSize:14.0,fontWeight: FontWeight.normal,colors: Colors.blueAccent),
                            ],
                          ),
                        ),
                      ]
                  ),
                ],
              ),
              Container(
                child:
                ListTile(
                  title:
                  //AdsText( text:ads.description,fontSize:14.0,fontWeight: FontWeight.normal,colors: Colors.black54),
                  Text(
                    ads.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15,height: 1.2),
                  ),
                  subtitle: Text("show more",style: TextStyle(fontSize:14,color: Colors.blueAccent),),
                  /*
                ExpansionTile(
                  title: AdsText( text:ads.university,fontSize:16.0,fontWeight: FontWeight.bold,colors: Colors.black54),
                  children: <Widget>[
                    ListTile(
                      title: AdsText( text:ads.description,fontSize:14.0,fontWeight: FontWeight.normal,colors: Colors.black54),
                      /* children: <Widget>[
                        ListTile(
                          title: Text('data'),
                        )
                      ], */
                    ),
                    /* ListTile(
                      title: Text(
                          post.city
                      ),
                    ), */
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: PostStats(model: ads, type:'ads'),
                    ),
                  ],
                ),
    */
              ),),
              Divider(),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top:5),
                child: PostStats(model: ads, type:'ads'),
              ),
            ],
          ),

        ),
        margin: EdgeInsets.only(left: 10, top: 10, right: 8, ),
        decoration: BoxDecoration(
          color: ads.userName == 'sara' ? Colors.redAccent : Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.all(
              Radius.circular(10) //
          ),
        ),
      ),
    );
  }
}



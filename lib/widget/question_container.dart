import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/screen/stateless_que.dart';
import 'package:roomie/widget/question_details.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// You can pass any object to the arguments parameter.
class ScreenArguments {
  final Questions question;
  final List<Like> likes;

  ScreenArguments(this.question , this.likes
);
}

class ScreenArguments1 {
  final Questions question;
  final ScrollController scrollController;
  //final List<Reply> cls;

  ScreenArguments1(this.question,this.scrollController
//this.cls
      );
}

class QuestionContainer extends StatelessWidget {
  final Questions question;
  final List<Like> likes;

  const QuestionContainer({
    Key key,
    @required this.question,
    @required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle descriptionStyle = theme.textTheme.subtitle1;
    //final bool isDesktop = Responsive.isDesktop(context);

   // question.createAt = DateFormat("dd-MM-yyyy").format(DateTime.parse(question.createAt));

    return new InkWell(
      //You need to make my child interactive
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionDetails(),
            settings: RouteSettings(
              arguments: ScreenArguments(question ,likes),
            ),
          ),
        );
      }, //ontap

      child: Container(
        child: new Card(
          margin: EdgeInsets.only(left: 0, right: 0, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _headerQuestion(context),
              _bodyQuestion(),
              Divider(),
              _bottomQuestion(context),
            ],
          ),

        ),
        margin: EdgeInsets.only(left: 10, top: 10, right: 8, ),
        decoration: BoxDecoration(
          //color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.all(
              Radius.circular(20) //
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  //************************
  Widget _bottomQuestion(context){
    final ScrollController _scrollController = new ScrollController();
    return Padding(
      padding: EdgeInsets.only(bottom: 5, top: 3),
      child: PostStats(model: question, type: 'question'),
    );
  }


  //-------------------------------------

  Widget _headerQuestion(context){
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(16),
            height: 70,
            width: 70,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:
                     Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.fill,
                ))),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            child: Text(
              question.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 3.0,
            ),
            child: Text(
              "Asked by : ${question.userName}",
              //maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  height: 1.2,
                  fontWeight: FontWeight.normal),
            ),
            //AdsText( text:question.title,fontSize:16.0,fontWeight: FontWeight.bold,colors: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  MdiIcons.tag,
                  size: 15,
                  color: Colors.blueGrey,
                ),
                AdsText(
                    text: "  ${question.tag}",
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    colors: Colors.blueAccent),
              ],
            ),
          ),
        ]),
      ],
    );

  }

  Widget _bodyQuestion(){
   return Container(
      child: ListTile(
        title:
        //AdsText( text:ads.description,fontSize:14.0,fontWeight: FontWeight.normal,colors: Colors.black54),
        Text(
          question.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, height: 1.2),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top:5),
          child: Text("replies: ${question.replies_count}",style: TextStyle(fontSize: 12, height: 1.2),),
        ),
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
      ),
    );
  }



}


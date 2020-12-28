import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rich_alert/rich_alert.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/model/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/provider/getcomment-provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:like_button/like_button.dart';


class QuestionDetails extends StatefulWidget {
  @override
  _QuestionDetailsState createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails> {
  final myController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  Users userLoad = Users();
  bool _delete = false;
  int _like;
  bool toggle = false;
  bool _isLiked;

  @override
  void initState() {
    super.initState();
    getPref();
  }


  getComment(context) async{
    getCommentProvider comments = Provider.of<getCommentProvider>(context);
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;


    var data = {
      'qid': args.question.queId,
    };
    print(data);
    var body = json.encode(data);
    print(body);
    await comments.getC(body).then((response) {
      print('Empty-------------------------------${response.isNotEmpty}');
      if (response.isNotEmpty) {
print('response-----------------------------------$response');
print('lenght-----------------------------${response.length}');
      }
      else {
        Flushbar(
          title: "Added your reply Failed",
          message: response['message'].toString(),
          //response['status'],
          duration: Duration(seconds: 10),
        ).show(context);
      }
    });




  }

  getPref() async {
    Users fMain = await UserPreferences().getUser();
    setState(() {
      userLoad = fMain;
    });
    print(fMain.name);
  }

  doComment() async {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    AddReplyProvider replies = Provider.of<AddReplyProvider>(context);
    var data = {
      'description': myController.text,
      'question_id': args.question.queId,
    };
    print(data);
    var body = json.encode(data);
    print(body);
    await replies.AddReply(body).then((response) {
      if (response['status']) {
        
        myController.clear();
        Provider.of<ReplyDetailsProvider>(context, listen: true).fetchReplyDetails();
        Provider.of<QuestionDetailsProvider>(context, listen: true).fetchPostDetails();
      } else {
        Flushbar(
          title: "Added your reply Failed",
          message: response['message'].toString(),
          //response['status'],
          duration: Duration(seconds: 10),
        ).show(context);
      }
    });
  }

  Future<bool> onLikeButtonTapped(isLiked) async{
    AddqueLikeProvider Likes = Provider.of<AddqueLikeProvider>(context);
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    var data = {
      'like': 1,
      'question_id': args.question.queId,
    };
    var body = json.encode(data);
    await Likes.AddqueLike(body).then((response) {
      if (response) {
        Provider.of<LikeDetailsProvider>(context, listen: false).fetchLikeDetails();
        Provider.of<QuestionDetailsProvider>(context, listen: false).fetchPostDetails();

        return !isLiked ;
      } else {
        Flushbar(
          title: "Like Failed",
          message: "Like Failed",
          //response['status'],
          duration: Duration(seconds: 10),
        ).show(context);
      }

    });
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    //return !isLiked;
  }

  doLike()  async {
    final    AddqueLikeProvider Likes = Provider.of<AddqueLikeProvider>(context);
    ScreenArguments args = ModalRoute.of(context).settings.arguments;

    if (toggle == true){_like = 0;}else{_like = 1;}
    var data = {
      'like': _like,
      'question_id': args.question.queId,
    };
    var body = json.encode(data);
    await Likes.AddqueLike(body).then((response) {
      if (response) {
        Provider.of<LikeDetailsProvider>(context, listen: false).fetchLikeDetails();
        Provider.of<QuestionDetailsProvider>(context, listen: false).fetchPostDetails();
        return toggle = true;
      } else {
        Flushbar(
          title: "Like Failed",
          message: "Like Failed",
          //response['status'],
          duration: Duration(seconds: 10),
        ).show(context);
        return toggle = false;
      }
    });
  }

  doUnlike() async {
    AddqueLikeProvider Likes = Provider.of<AddqueLikeProvider>(context);
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    RemovequeLikeProvider LikesRemove = Provider.of<RemovequeLikeProvider>(context);

    var data = {
      'question_id': args.question.queId,
    };
    var body = json.encode(data);
    await LikesRemove.RemovequeLike(body).then((response) {
      if (!response) {
        Provider.of<LikeDetailsProvider>(context, listen: false).fetchLikeDetails();
        Provider.of<QuestionDetailsProvider>(context, listen: false).fetchPostDetails();

        return toggle = false;
      } else {
        Flushbar(
          title: "Unlike Failed",
          message: "Unlike Failed",
          //response['status'],
          duration: Duration(seconds: 10),
        ).show(context);
        return toggle = true;
      }
    });
  }

  doDelete(int id) async {
    RemoveReplyProvider Rreplies = Provider.of<RemoveReplyProvider>(context);

    var data = {
      'reply_id': id,
    };
    var body = json.encode(data);
    await Rreplies.RemoveReply(body).then((response) {
      if (response['status']) {
        Provider.of<ReplyDetailsProvider>(context, listen: false)
            .fetchReplyDetails();
        Provider.of<QuestionDetailsProvider>(context, listen: false)
            .fetchPostDetails();
        Navigator.of(context, rootNavigator: true).pop();

        //Navigator.of(context).pop();
        /*
            Navigator.push(
              context,
              new MaterialPageRoute(

                  builder: (context) => Questiondetails()
              ),
            );
*/
      } else {
        Flushbar(
          title: "Delete Failed",
          message: response['status'].toString(),
          //response['status'],
          duration: Duration(seconds: 5),
        ).show(context);
      }
    });
  }

  //?*****************************************************
  //*****************************************************

  Widget _bodyquestionDetails(context, List<Reply> cls) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );


    List newCls = cls
        .where((o) => o.queId.toString() == args.question.queId.toString())
        .toList();


    if (cls.length != 0) {
      return ListView.separated(
          shrinkWrap: true,
          itemCount: cls.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1, color: Colors.grey),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index < cls.length) {
              if (cls[index].userName == userLoad.name) {
                _delete = true;
                print('reply id ........${cls[index].rId}');
              } else {
                _delete = false;
              }
              print(cls.length);
              print(index);
              return ListTile(
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: ExactAssetImage('assets/images/as.png'),
                  // NetworkImage('assets/images/as.png'),
                  backgroundColor: Colors.transparent,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: AdsText(
                              text: 'Created by ${cls[index].userName}',
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              colors: Colors.black45),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: AdsText(
                              text: 'Date ${cls[index].createAt}',
                              fontSize: 10.0,
                              fontWeight: FontWeight.normal,
                              colors: Colors.black45),
                        ),
                      ],
                    ),
                    _delete == true
                        ? IconButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (ctxt) => new AlertDialog(
                              title: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/as.png',
                                    fit: BoxFit.fitWidth,
                                    height: 300.0,
                                    width: MediaQuery.of(context).size.width,
                                    colorBlendMode: BlendMode.srcOver,
                                    //color: new Color.fromARGB(120, 20, 10, 40),
                                  ),
                                  Text("Delete Confirmation"),
                                ],
                              ),
                              content: Text(
                                  "Are you sure to delete this reply?"),
                              actions: [
                                cancelButton,
                                FlatButton(
                                  child: Text("Continue"),
                                  onPressed: () {
                                    doDelete(cls[index].rId);
                                  },
                                ), // set up the AlertDialog
                              ],
                            ) // show the dialog
                        );

                      },
                      //padding: EdgeInsets.only(top:80),
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                    )
                        : SizedBox()
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(cls[index].description),
                ),
              );
            } else {
              print(cls.length);
              return ListTile(
                title: Text(
                    'share your reply with ${args.question.replies_count}'),
              );
            }
          });
    } else {
      return SizedBox(
        height: 100,
        child: ListTile(
          title: Text('share your idea with ${args.question.userName}'),
        ),
      );
    }
  }

  Widget _buildIamge(context) {
    return new ClipPath(
      clipper: new DialogonalClipper(),
      child: new Image.asset(
        'assets/ava.jpg',
        fit: BoxFit.fitWidth,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        colorBlendMode: BlendMode.srcOver,
        //color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildProfileRow(context) {
    double _imageHeight = 256.0;
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

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
                    Icon(
                      MdiIcons.tag,
                      size: 30,
                      color: Colors.black45,
                    ),
                    new Text(
                      " ${args.question.tag}",
                      style: new TextStyle(
                          fontSize: 26.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                new Text(
                  "Created by: ${args.question.userName}",
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

  Widget _headerquestionDetails(context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return new Padding(
      padding: new EdgeInsets.only(left: 15.0, bottom: 15.0, top: 10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: new Text(
              args.question.title,
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                MdiIcons.tag,
                size: 15,
                color: Colors.black45,
              ),
              new Text(
                " ${args.question.tag}",
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 0),
            child: new Text(
              args.question.description,
              style: new TextStyle(
                  color: Colors.black45,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart(context) {
    double _imageHeight = 256.0;

    return new Padding(
      padding: new EdgeInsets.only(top: 1),
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
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return new Padding(
      padding: new EdgeInsets.only(left: 20.0, bottom: 30.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            args.question.title,
            style: new TextStyle(fontSize: 30.0),
          ),
          new Text(
            args.question.city,
            style: new TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildAdDetail(context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'sara.sabounchi@gmail.com',
        queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

    return Padding(
      padding: new EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Column(
        children: [
          Container(
            child: Text(
              args.question.description,
              style: TextStyle(fontSize: 15, height: 1.2),
              // style: new TextStyle(color: Colors.black, fontSize: 16 , height: 1.25, ),
            ),
          ),
          //Divider(color: Colors.black45,height: 20,thickness: 3),
        ],
      ),
    );
  }

  Widget _socialBar(context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Padding(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: PostStats(
        icon: (toggle == true)
            ? Icon(
          MdiIcons.thumbUp,
          color: Colors.grey[600],
          size: 20.0,
        )
            : Icon(
          MdiIcons.thumbUpOutline,
          color: Colors.grey[600],
          size: 20.0,
        ),
        model: args.question,
        type: 'reply',
        comment: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        },
        like: () async{
          setState(() {
            toggle = !toggle;
            getComment(context);
            // !toggle ? dounlike() : dolike();
            // toggle = !toggle;
          });
        },
      ),
    );
  }

  Widget  _commentBar() {
    return Container(
      color: Colors.white30,
      padding: EdgeInsets.all(8),
      height: 100,
      //heiğp-ight: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new CircleAvatar(
            minRadius: 20.0,
            maxRadius: 20.0,
            backgroundImage: new AssetImage('assets/images/as.png'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 160,
                controller: myController,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                //grow automatically
                decoration: InputDecoration(
                    hintText: "  Add ur reply",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.black45)),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: doComment),
        ],
      ),
    );
  }



//*******************************************************
  //*****************************************************

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    List Likess = args.likes.where((o) => o.queId == args.question.queId && userLoad.userId == o.userId).toList();
    //List newCls = args.cls.where((o) => o.queId == args.question.queId).toList();
    AddReplyProvider replies = Provider.of<AddReplyProvider>(context);
    AddqueLikeProvider Likes = Provider.of<AddqueLikeProvider>(context);
    RemovequeLikeProvider LikesRemove = Provider.of<RemovequeLikeProvider>(context);
    RemoveReplyProvider Rreplies = Provider.of<RemoveReplyProvider>(context);

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    _buildIamge(context),
                    _buildProfileRow(context),
                  ],
                ),
                /*
                IconButton(
                  icon: toggle ? Icon(Icons.adjust, size: 40, color: toggledOn ? Colors.green : Colors.blue)
                      :Icon(Icons.access_alarm, size: 40, color: toggledOn ? Colors.green : Colors.blue),
                  onPressed: () {
                    setState(() {
                      //dolike();
                      toggle = !toggle;
                    });
                  },
                ),
                LikeButton(
                  size: 30,
                  circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: ( isLiked) {
                    print("isLiked ************************* $isLiked");
                    return Icon(
                      Icons.home,
                      color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                      size: 30,
                    );
                  },
                  likeCount: args.question.likes_count,
                  countBuilder: (int count,  isLiked, String text) {
                    var color = toggle ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    return result;
                  },
                  onTap: onLikeButtonTapped,
                ),

                 */
                //   _buildProfileRow(context),
                _headerquestionDetails(context),
                Divider(),
                _socialBar(context),
                //*******************************************
                FutureBuilder(
                    future: getComment(context),
                    builder:(context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                            child:  _bodyquestionDetails(context, snapshot.data),
                          /*
                            ListView.builder(
                                itemCount: _faouriteList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text('${_faouriteList[index].title}');
                                }
                            )
                            */
                        );
                      }
                    }
                )



                //*******************************************
                /*
                Consumer<ReplyDetailsProvider>(
                    builder: (context, myrModel, child) {
                  if (myrModel.replies.status == Status.COMPLETED) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Divider(),
                        _bodyquestionDetails(context, myrModel.replies.data),
                        //pressed ? _commentBar() : SizedBox(),
                      ],
                    );
                  } else if (myrModel.replies.status != Status.COMPLETED) {
                    return Center(child: CircularProgressIndicator());
                  } else if (myrModel.replies.status == Status.ERROR) {
                    return Text("Error : ${myrModel.replies.message}");
                  } else {
                    return Text("${myrModel.replies.message}");
                  }
                }),
                */
                //*******************************************
              ],
            ),
            _commentBar(),
          ],
        ),
      ),
    );
  } //build context

} //class _QuestionDetailsState




class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 50.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}




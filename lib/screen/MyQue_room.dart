import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';

class MyQue extends StatefulWidget {
  @override
  _MyQueState createState() => _MyQueState();
}

class _MyQueState extends State<MyQue> {

  Users userLoad = Users();

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    Users fMain = await UserPreferences().getUser();

    setState(() {
      userLoad = fMain;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //automaticallyImplyLeading: false,
      ),
      body: Consumer2<QuestionDetailsProvider,LikeDetailsProvider>(
          builder: (context, mypModel,mylModel ,child) {
            if (mypModel.questions.status == Status.COMPLETED ) {

              List quess = mypModel.questions.data.where((o) => o.userId == userLoad.userId).toList();
              print(userLoad.userId);
              print(mypModel.questions.data[0].userId);
              print("lenght------------------${quess.length}");
              print(mypModel.questions.data.length);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 70),
                      itemCount: quess.length,
                      itemBuilder: (context, index) {
                        List<Like> projectL = mylModel.likes.data;
                        // print('Likeeeeeeeeee------$projectL');
                        //print(projectCL[0].queId);
                        Questions project = quess[index];
                        print('"243q41"------$project');
                        print(project.queId);
                        return QuestionContainer(
                          question: project,
                          likes: projectL,
                        );
                      },
                    ),
                  ),
                ],
              );

              //return Text("${myModel.album.data.length}");
            }
            else if (mypModel.questions.status == Status.LOADING ) {
              return Center(child: CircularProgressIndicator());
            }
            else if (mypModel.questions.status == Status.ERROR || mylModel.likes.status == Status.ERROR) {
              return Text(
                  "Error : ${mypModel.questions.message} ");
            }
            else {
              return Text(
                  "${mypModel.questions.message} ");
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/widget/widgets.dart';

class MyAds extends StatefulWidget {

  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {

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
      body: Consumer<AdsDetailsProvider>
        (builder: (context, myModel, child) {
        if (myModel.ads.status == Status.COMPLETED) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 70),
                  itemCount: myModel.ads.data.length,
                  itemBuilder: (context, index) {
                    Ads project = myModel.ads.data[index];
                    return AdsContainer(
                      ads: project,
                    );
                  },
//scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            ],
          );
          //print(myModel.ads.status);
          //return Text("${myModel.album.data.length}");
        } else if (myModel.ads.status != Status.COMPLETED) {
          return Center(
              child:
              //buildShowDialog(context),
              CircularProgressIndicator());
        } else if (myModel.ads.status == Status.ERROR) {
          return Text("Error : ${myModel.ads.message} ");
        } else {
          return Text("${myModel.ads.message}");
        }
      }),    );
  }
}

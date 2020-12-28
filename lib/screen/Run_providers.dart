import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/data/AppLanguage.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/Nav_room.dart';

class Runproviders extends StatelessWidget {

  Future<String> get() async {
    WidgetsFlutterBinding.ensureInitialized();
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await UserPreferences().getToken();

    //var token = prefs.getString('token');
    print('token------------------$token');
    return token;

    /* runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? MyApp() : NavScreen()));

  */
  }



  @override
  Widget build(BuildContext context) {
    String token;
    get().then((value) {
      token = value;
      print(token);
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdsDetailsProvider>(
            create: (context) => AdsDetailsProvider()),
        ChangeNotifierProvider<QuestionDetailsProvider>(
            create: (context) => QuestionDetailsProvider()),
        ChangeNotifierProvider<ReplyDetailsProvider>(
            create: (context) => ReplyDetailsProvider()),
        ChangeNotifierProvider<LikeDetailsProvider>(
            create: (context) => LikeDetailsProvider()),
        //ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
         ChangeNotifierProvider(create: (_) => AddAdsProvider()),
        ChangeNotifierProvider(create: (_) => AddQuestionProvider()),
        ChangeNotifierProvider(create: (_) => AddReplyProvider()),
        ChangeNotifierProvider(create: (_) => RemoveReplyProvider()),
        ChangeNotifierProvider(create: (_) => AddqueLikeProvider()),
        ChangeNotifierProvider(create: (_) => RemovequeLikeProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
        ChangeNotifierProvider(create: (_) => GetUserProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        //ChangeNotifierProvider(create: (_) => AppLanguage()),
        //ChangeNotifierProvider(create: (_) => ThemeModel()),

      ],
      child: MaterialApp(
        //theme: Provider.of<ThemeModel>(context).currentTheme,
        home: NavScreen(),
        //token == null ? Splash2() : NavScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}




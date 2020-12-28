







import 'package:flutter/material.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/data/aplocalization.dart';
import 'package:roomie/data/home.dart';
import 'package:roomie/data/providess.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:roomie/provider/getcomment-provider.dart';
import 'package:roomie/provider/getimage_provider.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/screens.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CurrentData currentData = CurrentData();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AddAdsProvider()),
        ChangeNotifierProvider(create: (_) => AddQuestionProvider()),
        ChangeNotifierProvider(create: (_) => AddReplyProvider()),
        ChangeNotifierProvider(create: (_) => RemoveReplyProvider()),
        ChangeNotifierProvider(create: (_) => AddqueLikeProvider()),
        ChangeNotifierProvider(create: (_) => RemovequeLikeProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
        ChangeNotifierProvider(create: (_) => GetUserProvider()),
        ChangeNotifierProvider(create: (_) => GetImageProvider()),
        ChangeNotifierProvider(create: (_) => getCommentProvider()),

      ],
      child: ChangeNotifierProvider(
        create: (context) => currentData,
        child: Consumer<CurrentData>(
          builder: (context, provider, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App Localization with Provider demo',
            locale: Provider.of<CurrentData>(context).locale,
            home: Login(),
            localizationsDelegates: [
              const AppLocalizationDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('fr'),
              const Locale('es'),
              const Locale('ru'),
              const Locale('ar'),
            ],
          ),
        ),
      ),
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'GeeksForGeeks',
        textScaleFactor: 2,
      ),
      image: new Image.network(
          'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
      // loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.transparent,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Facebook UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: Login(),
    );
  }
}



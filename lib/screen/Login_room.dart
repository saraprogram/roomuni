import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomie/config/api_response.dart';
import 'package:roomie/data/AppLanguage.dart';
import 'package:roomie/data/aplocalization.dart';
//import 'package:roomie/data/app_localizations.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/screen/Run_providers.dart';
import 'package:roomie/screen/screens.dart';
import 'package:roomie/widget/widgets.dart';
import 'package:roomie/localizations.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final formKey = new GlobalKey<FormState>();
  String _username, _password;
  bool _isloading = false;

  label1(String title) => Text(title);

  @override
  Widget build(BuildContext context) {
    LoginProvider log = Provider.of<LoginProvider>(context);
    //var appLanguage = Provider.of<AppLanguage>(context);

    var dodo = () async {};

    var loading = Stack(
      children: [
        longButtons(
          title: "login",
          fun: dodo,
          color: Colors.black45,
          textcolor: Colors.red,
        ),
        Container(
            padding: EdgeInsets.only(left: 80, top: 10),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )),
        //Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => Register()),
            );
          },
        ),
      ],
    );

    doLogin() async {
      final form = _key.currentState;

      if (form.validate()) {
        setState(() {
          _isloading = true;
        });
        form.save();
        var data = {
          'email': _username,
          'password': _password,
        };
        await log.Login(data).then((response) async {
          if (log.logs.status == Status.LOADING) {
            print(log.logs.status);
          }
          if (response['status'] == 'success') {
            var user_data = response['data'];
            print(user_data);

            var user_set = Users.fromJson(user_data['user'][0]);
            Provider.of<UserProvider>(context, listen: false).setUser(user_set);
            //--------------------------------
            
             //-------------------------------
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => NavScreen()),
            );
          }
        }).catchError((error) => Flushbar(
              title: "Failed Login",
              message: error.toString(),
              duration: Duration(seconds: 5),
            ).show(context));
      } else {
        Flushbar(
          title: "Invalid Input",
          message: "Please fill Email and Password properly",
          duration: Duration(seconds: 5),
        ).show(context);
      }
      setState(() {
        _isloading = false;
      });
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 350.0),
              Container(
                padding: EdgeInsets.all(40.0),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      label1("Email"),
                      SizedBox(height: 5.0),
                      CustomTextFormField(
                        hint:                 AppLocalization.of(context).translate('hello-world'),

                        message:                 AppLocalization.of(context).translate('hello-world'),

                        inputType: TextInputType.emailAddress,
                        variable: (value) => _username = value,
                        obscure: false,
                        icon: Icons.email,
                      ),
                      SizedBox(height: 20.0),
                      label1("Password"),
                      SizedBox(height: 5.0),
                      CustomTextFormField(
                        hint:                  AppLocalization.of(context).translate('hello-world'),

                        message: "please enter your password",
                        inputType: TextInputType.visiblePassword,
                        variable: (value) => _password = value,
                        obscure: true,
                        icon: Icons.lock,
                      ),
                      SizedBox(height: 20.0),
                      forgotLabel,
                      SizedBox(height: 5.0),
                      log.logs.status == Status.LOADING
                          ? loading
                          : longButtons(
                              title: "login",
                              fun: doLogin,
                              color: Colors.black45,
                              textcolor: Colors.red,
                            ),
                      SizedBox(height: 5.0),
                      longButtons(
                        title: "google login",
                        fun: doLogin,
                        color: Colors.black45,
                        textcolor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eShop/screens/register_screens/login_screen.dart';
import 'package:eShop/screens/register_screens/registration_screen.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/strings.dart';
import 'package:eShop/widgets/allWidgets.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _showCloseAppDialog();
        return Future.value(true);
      },
      child: Scaffold(
        body: primaryContainer(
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    "assets/images/wellcome.svg",
                    height: 200,
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('welcom to pet shop'),
                    style: boldFont(MColors.textDark, 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('welcome_message'),
                    style: normalFont(MColors.textGrey, 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150.0,
          color: MColors.primaryWhite,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              primaryButtonPurple(
                Text(
                  AppLocalizations.of(context).translate('sign in'),
                  style: boldFont(MColors.primaryWhite, 16.0),
                ),
                () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              primaryButtonWhiteSmoke(
                Text(
                  AppLocalizations.of(context).translate('create an account'),
                  style: boldFont(MColors.primaryPurple, 16.0),
                ),
                () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => RegistrationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCloseAppDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Are you sure you want to leave?",
              style: normalFont(MColors.textGrey, 14.0),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: normalFont(MColors.textGrey, 14.0),
                ),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  "Leave",
                  style: normalFont(Colors.redAccent, 14.0),
                ),
              ),
            ],
          );
        });
  }
}

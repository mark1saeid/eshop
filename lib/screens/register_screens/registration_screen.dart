import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eShop/main.dart';
import 'package:eShop/model/notifiers/userData_notifier.dart';
import 'package:eShop/model/services/user_management.dart';
import 'package:eShop/screens/register_screens/login_screen.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/textFieldFormaters.dart';
import 'package:eShop/widgets/allWidgets.dart';
import 'package:eShop/widgets/provider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _name;
  String _phone;
  String _email;
  String _password;
  String _error;
  bool _autoValidate = false;
  bool _isButtonDisabled = false;
  bool _obscureText = true;
  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDataProfileNotifier>(
      create: (BuildContext context) => UserDataProfileNotifier(),
      child: Consumer<UserDataProfileNotifier>(
        builder: (context, profileNotifier, _) {
          return Scaffold(
            backgroundColor: MColors.primaryWhiteSmoke,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: primaryContainer(
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        AppLocalizations.of(context).translate('create your free account'),
                        style: boldFont(MColors.textDark, 38.0),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            AppLocalizations.of(context).translate('Already have an account'),
                            style: normalFont(MColors.textGrey, 16.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            child: Text(
                              AppLocalizations.of(context).translate('Sign in!')
                              ,
                              style: normalFont(MColors.primaryPurple, 16.0),
                              textAlign: TextAlign.start,
                            ),
                            onTap: () {
                              formKey.currentState.reset();
                              Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0),

                    showAlert(),

                    SizedBox(height: 10.0),

                    //FORM
                    Form(
                      key: formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).translate('name')
                                 ,
                                  style: normalFont(MColors.textGrey, null),
                                ),
                              ),
                              primaryTextField(
                                null,
                                null,
                                "Remiola",
                                (val) => _name = val,
                                _isEnabled,
                                NameValiditor.validate,
                                false,
                                _autoValidate,
                                true,
                                TextInputType.text,
                                null,
                                null,
                                0.50,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).translate('email')
                                  ,
                                  style: normalFont(MColors.textGrey, null),
                                ),
                              ),
                              primaryTextField(
                                null,
                                null,
                                "e.g example@gmail.com",
                                (val) => _email = val,
                                _isEnabled,
                                EmailValiditor.validate,
                                false,
                                _autoValidate,
                                true,
                                TextInputType.emailAddress,
                                null,
                                null,
                                0.50,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).translate('password')
                                 ,
                                  style: normalFont(MColors.textGrey, null),
                                ),
                              ),
                              primaryTextField(
                                null,
                                null,
                                null,
                                (val) => _password = val,
                                _isEnabled,
                                PasswordValiditor.validate,
                                _obscureText,
                                _autoValidate,
                                false,
                                TextInputType.text,
                                null,
                                SizedBox(
                                  height: 20.0,
                                  width: 40.0,
                                  child: RawMaterialButton(
                                    onPressed: _toggle,
                                    child: Text(
                                      _obscureText ?AppLocalizations.of(context).translate('show')  :AppLocalizations.of(context).translate('Hide') ,
                                      style: TextStyle(
                                        color: MColors.primaryPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                0.50,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Text(
                              AppLocalizations.of(context).translate('your password message'),
                              style: normalFont(MColors.primaryPurple, null),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).translate('phone number'),
                                  style: normalFont(MColors.textGrey, null),
                                ),
                              ),
                              primaryTextField(
                                null,
                                null,
                                "e.g +02 (12) 12345 6789",
                                (val) => _phone = val,
                                _isEnabled,
                                PhoneNumberValiditor.validate,
                                false,
                                _autoValidate,
                                true,
                                TextInputType.numberWithOptions(),
                                [maskTextInputFormatter],
                                null,
                                0.50,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: Text(
                                  AppLocalizations.of(context).translate('your number message')
                                  ,
                                  style:
                                      normalFont(MColors.primaryPurple, null),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.verified_user,
                                    color: MColors.primaryPurple,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        AppLocalizations.of(context).translate('by continuing')
                                        ,
                                        style:
                                            normalFont(MColors.textGrey, null),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              _isButtonDisabled == true
                                  ? primaryButtonPurple(
                                      //if button is loading
                                      progressIndicator(Colors.white),
                                      null,
                                    )
                                  : primaryButtonPurple(
                                      Text(
                                        AppLocalizations.of(context).translate('next step')
                                        ,
                                        style: boldFont(
                                          MColors.primaryWhite,
                                          16.0,
                                        ),
                                      ),
                                      _isButtonDisabled ? null : _submit,
                                    ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              child: Text(
                _error,
                style: normalFont(Colors.redAccent, 15.0),
              ),
            ),
          ],
        ),
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: MColors.primaryWhiteSmoke,
          border: Border.all(width: 1.0, color: Colors.redAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _submit() async {
    final form = formKey.currentState;

    try {
      final auth = MyProvider.of(context).auth;

      if (form.validate()) {
        form.save();

        if (mounted) {
          setState(() {
            _isButtonDisabled = true;
            _isEnabled = false;
          });
        }

        String uid = await auth.createUserWithEmailAndPassword(
          _email,
          _password,
          _phone,
        );

        storeNewUser(_name, _phone, _email);
        print("Signed Up with new $uid");

        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => MyApp(),
          ),
        );
      } else {
        setState(() {
          _autoValidate = true;
          _isEnabled = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.message;
          _isButtonDisabled = false;
          _isEnabled = true;
        });
      }

      print("ERRORR ==>");
      print(e);
    }
  }
}

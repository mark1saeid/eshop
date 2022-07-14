import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/material.dart';
import 'package:eShop/utils/cardUtils/cardStrings.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/widgets/allWidgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String password;
  bool _autoValidate = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          AppLocalizations.of(context).translate('change password')
          ,
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context).translate('save')
              ,
              style: boldFont(MColors.primaryPurple, 14.0),
            ),
          )
        ],
      ),
      body: primaryContainer(
        SingleChildScrollView(
          child: Form(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('current password')
                          ,
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
                            height: 20.0,
                            width: 35.0,
                            child: RawMaterialButton(
                              onPressed: _toggle,
                              child: new Text(
                                _obscureText ? AppLocalizations.of(context).translate('show')  :AppLocalizations.of(context).translate('Hide'),
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
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('new password')
                         ,
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
                            height: 20.0,
                            width: 35.0,
                            child: RawMaterialButton(
                              onPressed: _toggle,
                              child: new Text(
                                _obscureText ? AppLocalizations.of(context).translate('show')  :AppLocalizations.of(context).translate('Hide'),
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
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('confirm new password')
                          ,
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
                            height: 20.0,
                            width: 35.0,
                            child: RawMaterialButton(
                              onPressed: _toggle,
                              child: new Text(
                                _obscureText ? AppLocalizations.of(context).translate('show')  :AppLocalizations.of(context).translate('Hide'),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

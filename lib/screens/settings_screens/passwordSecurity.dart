import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eShop/screens/settings_screens/changePassword.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/permission_handler.dart';
import 'package:eShop/widgets/allWidgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listTileIcons = [
      "assets/images/key.svg",
      "assets/images/icons/Location.svg",
    ];

    final listTileNames = [
      AppLocalizations.of(context).translate('change password'),
      AppLocalizations.of(context).translate('location'),
    ];

    final listTileActions = [
      () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => ChangePasswordScreen(),
          ),
        );
      },
      () {
        PermissionUtil.isLocationServiceAndPermissionsActive().then((value) {
          if (value == false) {
            PermissionUtil.requestPermission(Permission.location);
          }
        });
      },
    ];

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
          AppLocalizations.of(context).translate('security')
     ,
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: listTileNames.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Container(
                child: Column(
                  children: <Widget>[
                    listTileButton(
                      listTileActions[i],
                      listTileIcons[i],
                      listTileNames[i],
                      MColors.primaryPurple,
                    ),
                    Divider(
                      height: 1.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

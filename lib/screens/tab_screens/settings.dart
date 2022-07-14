import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eShop/main.dart';
import 'package:eShop/model/notifiers/userData_notifier.dart';
import 'package:eShop/model/services/auth_service.dart';
import 'package:eShop/model/services/pushNotification_service.dart';
import 'package:eShop/model/services/user_management.dart';
import 'package:eShop/screens/settings_screens/cards.dart';
import 'package:eShop/screens/settings_screens/editProfile.dart';
import 'package:eShop/screens/settings_screens/passwordSecurity.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/internetConnectivity.dart';
import 'package:eShop/widgets/allWidgets.dart';
import 'package:eShop/widgets/provider.dart';
import 'package:provider/provider.dart';

import 'checkout_screens/enterAddress.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future profileFuture;
  Future addressFuture;

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
      value == true
          ? () {
        UserDataProfileNotifier profileNotifier =
        Provider.of<UserDataProfileNotifier>(context,
            listen: false);
        profileFuture = getProfile(profileNotifier);

        UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context,
            listen: false);
        addressFuture = getAddress(addressNotifier);
      }()
          : showNoInternetSnack(_scaffoldKey)
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataProfileNotifier profileNotifier =
    Provider.of<UserDataProfileNotifier>(context);
    var checkUser = profileNotifier.userDataProfileList;
    var user;
    checkUser.isEmpty || checkUser == null
        ? user = null
        : user = checkUser.first;

    UserDataAddressNotifier addressNotifier =
    Provider.of<UserDataAddressNotifier>(context);
    var checkaddressList = addressNotifier.userDataAddressList;
    var addressList;
    checkaddressList.isEmpty || checkaddressList == null
        ? addressList = null
        : addressList = checkaddressList;

    return FutureBuilder(
      future: Future.wait([
        profileFuture,
        addressFuture,
      ]),
      builder: (c, s) {
        switch (s.connectionState) {
          case ConnectionState.active:
            return progressIndicator(MColors.primaryPurple);
            break;
          case ConnectionState.done:
            return checkUser.isEmpty || checkUser == null
                ? progressIndicator(MColors.primaryPurple)
                : showSettings(user, addressList);

            break;
          case ConnectionState.waiting:
            return progressIndicator(MColors.primaryPurple);
            break;
          default:
            return progressIndicator(MColors.primaryPurple);
        }
      },
    );
  }

  Widget showSettings(user, addressList) {
    var _checkAddress;
    addressList == null || addressList.isEmpty
        ? _checkAddress = null
        : _checkAddress = addressList.first;
    var _address = _checkAddress;

    // ============ Setting Task =================

    GestureDetector customCard(
        {@required String title,
          @required Function onTapfunction,
          Color color = Colors.black,
          Color colorIcon = Colors.black}) {
      return GestureDetector(
        onTap: onTapfunction,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .09,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 1.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 17),
                  ),
                ),
                // ================= need to be text =================

                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child:
                  Icon(Icons.arrow_forward_ios, size: 20, color: colorIcon),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: MColors.primaryWhiteSmoke,
        key: _scaffoldKey,
        body: primaryContainer(SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width * .9,
                            child: Card(
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: MediaQuery.of(context).size.height*0.045),
                                  Text(
                                    user.name,
                                    style:
                                    boldFont(Colors.black, 16.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
                                    child: Text(
                                      _address.addressNumber + ", " + _address.addressLocation,
                                      style: normalFont(MColors.textGrey, 14.0),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            left: MediaQuery.of(context).size.width * .33,
                            width: 90,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Hero(
                                  tag: "profileAvatar",
                                  child: user.profilePhoto == null ||
                                      user.profilePhoto == ""
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: Image.asset(
                                      "assets/images/ShopWBac.png",
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    child: FadeInImage.assetNetwork(
                                      image: user.profilePhoto,
                                      fit: BoxFit.fill,
                                      height: 80.0,
                                      width: 80.0,
                                      placeholder:
                                      "assets/images/ShopWBac.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

// ================= end profile =================
                    SizedBox(height: 10,),
                    customCard(
                      title:AppLocalizations.of(context).translate('edit profile') ,
                      onTapfunction: () async {
                        UserDataProfileNotifier profileNotifier =
                        Provider.of<UserDataProfileNotifier>(context,
                            listen: false);
                        var navigationResult = await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => EditProfile(user),
                          ),
                        );
                        if (navigationResult == true) {
                          setState(() {
                            getProfile(profileNotifier);
                          });
                          showSimpleSnack(
                            AppLocalizations.of(context).translate('profile has been updated') ,
                            Icons.check_circle_outline,
                            Colors.green,
                            _scaffoldKey,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 15,),
                    customCard(
                        onTapfunction: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => SecurityScreen(),
                            ),
                          );
                        },
                        title:AppLocalizations.of(context).translate('security') ),
                    SizedBox(height: 15,),
                    customCard(
                      title:AppLocalizations.of(context).translate('cards') ,
                      onTapfunction: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Cards1(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15,),
                    customCard(
                      title:AppLocalizations.of(context).translate('address') ,
                      onTapfunction: () async {
                        var navigationResult = await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Address(_address, addressList),
                          ),
                        );
                        if (navigationResult == true) {
                          UserDataAddressNotifier addressNotifier =
                          Provider.of<UserDataAddressNotifier>(context,
                              listen: false);

                          setState(() {
                            getAddress(addressNotifier);
                          });
                          showSimpleSnack(AppLocalizations.of(context).translate('address has been updated')
                            ,
                            Icons.check_circle_outline,
                            Colors.green,
                            _scaffoldKey,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 15,),
                    customCard(
                      title:AppLocalizations.of(context).translate('Invite a friend') ,
                      onTapfunction: () {
                        shareWidget();
                      },
                    ),
                    SizedBox(height: 15,),
                    customCard(
                      title:AppLocalizations.of(context).translate('Help') ,
                      onTapfunction: () {},
                    ),
                    SizedBox(height: 15,),
                    customCard(
                      title:AppLocalizations.of(context).translate('FAQs') ,
                      onTapfunction: () {
                        mockNotifications();
                      },
                    ),
                    SizedBox(height: 15,),
                    customCard(
                        title:AppLocalizations.of(context).translate('Sign Out') ,
                        onTapfunction: () {
                          _showLogOutDialog();
                        },
                        color: Colors.red[600],
                        colorIcon: Colors.red[600]),
                    SizedBox(height: 10),
                  ]),
            ))));
  }

  void _showLogOutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context).translate('are you sure you want to sign out')
              ,
              style: normalFont(MColors.textGrey, 14.0),
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).translate('cancel')
                  ,
                  style: normalFont(MColors.textGrey, 14.0),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  try {
                    AuthService auth = MyProvider.of(context).auth;
                    auth.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (_) => MyApp(),
                      ),
                    );
                    print("Signed out.");
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  AppLocalizations.of(context).translate('Sign out')
                  ,
                  style: normalFont(Colors.redAccent, 14.0),
                ),
              ),
            ],
          );
        });
  }
}

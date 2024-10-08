import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eShop/main.dart';
import 'package:eShop/model/data/userData.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/widgets/allWidgets.dart';

class OrderPlaced extends StatefulWidget {
  final List<UserDataAddress> addressList;
  OrderPlaced(this.addressList);
  @override
  _OrderPlacedState createState() => _OrderPlacedState(addressList);
}

class _OrderPlacedState extends State<OrderPlaced> {
  final List<UserDataAddress> addressList;
  _OrderPlacedState(this.addressList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.close,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => MyApp(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        null,
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: primaryContainer(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MColors.dashPurple,
                  ),
                  child: Icon(
                    Icons.check,
                    color: MColors.primaryPurple,
                    size: 30.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  AppLocalizations.of(context).translate('thank you')
                  ,
                  style: boldFont(MColors.textDark, 20.0),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate('your order has been successfully placed')
                    ,
                    style: boldFont(MColors.textGrey, 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  "assets/images/orderPlaced.svg",
                  height: 150,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  AppLocalizations.of(context).translate('an order confirmation')
                  ,
                  style: normalFont(MColors.textGrey, 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('your purchased items will be delivered to')
                      ,
                      style: normalFont(MColors.textGrey, 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      addressList.first.addressNumber +
                          ", " +
                          addressList.first.addressLocation,
                      style: boldFont(MColors.textGrey, 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: primaryButtonPurple(
          Text(AppLocalizations.of(context).translate('back home'), style: boldFont(MColors.primaryWhite, 16.0)),
          () {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => MyApp(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
    );
  }
}

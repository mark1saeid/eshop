import 'package:flutter/material.dart';
import 'package:eShop/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColors.primaryWhiteSmoke,
      child: Center(
        child: Container(
          height: 50.0,
          child:
              Image.asset("assets/images/ShopBac.png"),
        ),
      ),
    );
  }
}

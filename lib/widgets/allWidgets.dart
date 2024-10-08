import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eShop/model/data/Products.dart';
import 'package:eShop/model/notifiers/cart_notifier.dart';
import 'package:eShop/model/services/Product_service.dart';
import 'package:eShop/screens/tab_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:eShop/utils/colors.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

//SCAFFOLDS-----------------------------------
Widget primaryContainer(
  Widget containerChild,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    color: MColors.primaryWhiteSmoke,
    child: containerChild,
  );
}
//--------------------------------------------

//APPBARS-------------------------------------

Widget primaryAppBar(
  Widget leading,
  Widget title,
  Color backgroundColor,
  PreferredSizeWidget bottom,
  bool centerTile,
  List<Widget> actions,
) {
  return AppBar(
    brightness: Brightness.light,
    elevation: 0.0,
    backgroundColor: backgroundColor,
    leading: leading,
    title: title,
    bottom: bottom,
    centerTitle: centerTile,
    actions: actions,
  );
}

Widget primarySliverAppBar(
  Widget leading,
  Widget title,
  Color backgroundColor,
  PreferredSizeWidget bottom,
  bool centerTile,
  bool floating,
  bool pinned,
  List<Widget> actions,
  double expandedHeight,
  Widget flexibleSpace,
) {
  return SliverAppBar(
    brightness: Brightness.light,
    elevation: 0.0,
    backgroundColor: backgroundColor,
    leading: leading,
    title: title,
    bottom: bottom,
    centerTitle: centerTile,
    floating: floating,
    pinned: pinned,
    actions: actions,
    expandedHeight: expandedHeight,
    flexibleSpace: flexibleSpace,
  );
}
//--------------------------------------------

//FONTS---------------------------------------
TextStyle boldFont(Color color, double size) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
  );
}

TextStyle normalFont(Color color, double size) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: size,
  );
}
//--------------------------------------------

//BUTTONS-------------------------------------
Widget primaryButtonPurple(
  Widget buttonChild,
  void Function() onPressed,
) {
  return SizedBox(
    width: double.infinity,
    height: 50.0,
    child: RawMaterialButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      fillColor: MColors.primaryPurple,
      child: buttonChild,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
    ),
  );
}

Widget primaryButtonWhiteSmoke(
  Widget buttonChild,
  void Function() onPressed,
) {
  return SizedBox(
    width: double.infinity,
    height: 50.0,
    child: RawMaterialButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      fillColor: MColors.primaryWhiteSmoke,
      child: buttonChild,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
    ),
  );
}

Widget listTileButton(
  void Function() onPressed,
  String iconImage,
  String listTileName,
  Color color,
) {
  return SizedBox(
    height: 60.0,
    width: double.infinity,
    child: RawMaterialButton(
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            iconImage,
            height: 20,
            color: MColors.textGrey,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Text(
              listTileName,
              style: normalFont(color, 14.0),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16.0,
          ),
        ],
      ),
    ),
  );
}
//-------------------------------------------

//TEXTFIELDS--------------------------------

Widget primaryTextField(
  TextEditingController controller,
  String initialValue,
  String labelText,
  void Function(String) onsaved,
  bool enabled,
  String Function(String) validator,
  bool obscureText,
  bool autoValidate,
  bool enableSuggestions,
  TextInputType keyboardType,
  List<TextInputFormatter> inputFormatters,
  Widget suffix,
  double textfieldBorder,
) {
  return TextFormField(
    controller: controller,
    initialValue: initialValue,
    onSaved: onsaved,
    enabled: enabled,
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    autovalidate: autoValidate,
    enableSuggestions: enableSuggestions,
    style: normalFont(
      enabled == true ? MColors.textDark : MColors.textGrey,
      16.0,
    ),
    cursorColor: MColors.primaryPurple,
    decoration: InputDecoration(
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          right: suffix == null ? 0.0 : 15.0,
          left: suffix == null ? 0.0 : 15.0,
        ),
        child: suffix,
      ),
      labelText: labelText,
      labelStyle: normalFont(null, 14.0),
      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
      fillColor: MColors.primaryWhite,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: textfieldBorder == 0.0 ? Colors.transparent : MColors.textGrey,
          width: textfieldBorder,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: MColors.primaryPurple,
          width: 1.0,
        ),
      ),
    ),
  );
}

Widget searchTextField(
  bool autofocus,
  TextEditingController controller,
  String initialValue,
  String labelText,
  void Function(String) onsaved,
  void Function(String) onChanged,
  bool enabled,
  String Function(String) validator,
  bool obscureText,
  bool autoValidate,
  bool enableSuggestions,
  TextInputType keyboardType,
  List<TextInputFormatter> inputFormatters,
  Widget suffix,
  double textfieldBorder,
) {
  return TextFormField(
    autofocus: autofocus,
    controller: controller,
    initialValue: initialValue,
    onSaved: onsaved,
    onChanged: onChanged,
    enabled: enabled,
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    autovalidate: autoValidate,
    enableSuggestions: enableSuggestions,
    style: normalFont(
      enabled == true ? MColors.textDark : MColors.textGrey,
      16.0,
    ),
    cursorColor: Colors.black,
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          right: suffix == null ? 0.0 : 15.0,
          left: suffix == null ? 0.0 : 15.0,
        ),
        child: suffix,
      ),
      labelText: labelText,
      labelStyle: normalFont(null, 14.0),
      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
      fillColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: textfieldBorder == 0.0 ? MColors.lightGrey : MColors.lightGrey,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: MColors.primaryPurple,
          width: 1.0,
        ),
      ),
    ),
  );
}
//-------------------------------------------

//PROGRESS----------------------------------
Widget progressIndicator(Color color) {
  return Container(
    color: MColors.primaryWhiteSmoke,
    child: Center(
      child: CupertinoActivityIndicator(
        radius: 12.0,
      ),
    ),
  );
}

Widget gettingLocationIndicator() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(

          "Getting your current location",
          style: normalFont(MColors.textGrey, 14.0),
        ),
        SizedBox(width: 5.0),
        progressIndicator(MColors.primaryPurple),
      ],
    ),
  );
}
//-------------------------------------------

//SNACKBARS----------------------------------
void showSimpleSnack(
  String value,
  IconData icon,
  Color iconColor,
  GlobalKey<ScaffoldState> _scaffoldKey,
) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              value,
              style: normalFont(null, null),
            ),
          ),
          Icon(
            icon,
            color: iconColor,
          )
        ],
      ),
    ),
  );
}

void showNoInternetSnack(
  GlobalKey<ScaffoldState> _scaffoldKey,
) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 7000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "No internet connection! Please connect to the internet to continue.",
              style: normalFont(null, null),
            ),
          ),
          Icon(
            Icons.error_outline,
            color: Colors.amber,
          )
        ],
      ),
    ),
  );
}
//-------------------------------------------

//EMPTYCART----------------------------------
Widget emptyScreen(
  String image,
  String title,
  String subTitle,
) {
  return primaryContainer(
    Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                image,
                height: 150,
              ),
            ),
            Container(
              child: Text(
                title,
                style: boldFont(MColors.textDark, 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Text(
                subTitle,
                style: normalFont(MColors.textGrey, 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ------------------------------------------

//CART DISMISS-------------------------------
Widget backgroundDismiss(AlignmentGeometry alignment) {
  return Container(
    decoration: BoxDecoration(
      color: MColors.primaryWhiteSmoke,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    alignment: alignment,
    child: Container(
      height: double.infinity,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Icon(
        Icons.delete_outline,
        color: Colors.white,
      ),
    ),
  );
}
//-------------------------------------------

//WARNING------------------------------------
Widget warningWidget() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
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
            child: Container(
              child: Text(
                "PLEASE NOTE -  This is a side project by BrainOver. Please do not enter real info. Thank you!",
                style: normalFont(Colors.redAccent, 14.0),
              ),
            ),
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.redAccent),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
    ),
  );
}
//-------------------------------------------

//SHARE WIDGET-------------------------------
Future shareWidget() {
  return WcFlutterShare.share(
      sharePopupTitle: 'E Shop',
      subject: 'Hi!',
      text:
          'Hi, I use E Shop to buy products fast and easy, Download it here at # and for every download, you can get a free product.',
      mimeType: 'text/plain');
}
//-------------------------------------------

//MODAL BAR WIDGET-------------------------------
modalBarWidget() {
  return Container(
    height: 6.0,
    child: Center(
      child: Container(
        width: 50.0,
        height: 6.0,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    ),
  );
}
//-------------------------------------------

//ORDER TRACKER WIDGET-------------------------------
orderTrackerWidget(String status) {
  bool processing = false,
      confirmed = false,
      enRoute = false,
      delivered = false;

  if (status == "Processing") {
    processing = true;
  } else if (status == "Confirmed") {
    processing = true;
    confirmed = true;
  } else if (status == "On Delivery") {
    processing = true;
    confirmed = true;
    enRoute = true;
  } else if (status == "Delivered") {
    processing = true;
    confirmed = true;
    enRoute = true;
    delivered = true;
  } else {
    processing = true;
  }

  Widget checkMark() {
    return Icon(
      Icons.check,
      color: MColors.primaryWhite,
      size: 12.0,
    );
  }

  Widget smallDonut() {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: MColors.primaryWhiteSmoke,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
  }

  Widget bar(Color color) {
    return Container(
      width: 70.0,
      height: 3.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }

  Widget checkPoint(Color color, Widget center) {
    return Container(
        width: 16.0,
        height: 16.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: center);
  }

  return Container(
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Processing",
              style: normalFont(
                  processing ? Colors.green : Colors.grey[400], 8.0),
            ),
            SizedBox(width: 35.0),
            Text(
              "Confirmed",
              style:
                  normalFont(confirmed ? Colors.green : Colors.grey[400],8.0),
            ),
            SizedBox(width: 35.0),
            Text(
              "On Delivery",
              style:
                  normalFont(enRoute ? Colors.green : Colors.grey[400], 8.0),
            ),
            SizedBox(width: 35.0),
            Text(
              "Delivered",
              style:
                  normalFont(delivered ? Colors.green : Colors.grey[400], 8.0),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //PROCESSING
            checkPoint(
              processing ? Colors.green : Colors.grey[400],
              Center(
                child: processing && confirmed ? checkMark() : smallDonut(),
              ),
            ),

            SizedBox(width: 5.0),

            bar(confirmed ? Colors.green : Colors.grey[400]),

            SizedBox(width: 5.0),

            //CONFIRMED
            checkPoint(
              confirmed ? Colors.green : Colors.grey[400],
              Center(
                child: confirmed && enRoute ? checkMark() : smallDonut(),
              ),
            ),

            SizedBox(width: 5.0),

            bar(enRoute ? Colors.green : Colors.grey[400]),

            SizedBox(width: 5.0),

            //EN ROUTE
            checkPoint(
              enRoute ? Colors.green : Colors.grey[400],
              Center(
                child: enRoute && delivered ? checkMark() : smallDonut(),
              ),
            ),

            SizedBox(width: 5.0),

            bar(delivered ? Colors.green : Colors.grey[400]),

            SizedBox(width: 5.0),

            //DELIVERED
            checkPoint(
              delivered ? Colors.green : Colors.grey[400],
              Center(
                child: delivered ? checkMark() : smallDonut(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//-------------------------------------------
Widget blockWigdet(
  String blockTitle,
  String blockSubTitle,
  double _picHeight,
  double _itemHeight,
  List<ProdProducts> prods,
  CartNotifier cartNotifier,
  Iterable<String> cartProdID,
  GlobalKey _scaffoldKey,
  BuildContext context,
  allProds,
  void Function() seeMore,
) {
  void addToBagshowDialog(
      _product, cartNotifier, cartProdID, scaffoldKey) async {
    await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              "Sure you want to add to Bag?",
              style: normalFont(MColors.textDark, null),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "Cancel",
                  style: normalFont(Colors.red, null),
                ),
                onPressed: () async {
                  getCart(cartNotifier);

                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  "Yes",
                  style: normalFont(Colors.blue, null),
                ),
                onPressed: () {
                  getCart(cartNotifier);

                  if (cartProdID.contains(_product.productID)) {
                    showSimpleSnack(
                      "Product already in bag",
                      Icons.error_outline,
                      Colors.amber,
                      scaffoldKey,
                    );
                  } else {
                    addProductToCart(_product);
                    showSimpleSnack(
                      "Product added to bag",
                      Icons.check_circle_outline,
                      Colors.green,
                      scaffoldKey,
                    );

                    getCart(cartNotifier);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: _itemHeight / 1.15,
        // color: Colors.pink[200],
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: prods.length,
            itemBuilder: (context, i) {
              var product = prods[i];

              return GestureDetector(
                onTap: () async {
                  var navigationResult = await Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) =>
                          ProductDetailsProv(product, allProds),
                    ),
                  );
                  if (navigationResult == true) {
                    getCart(cartNotifier);
                  }
                },
                child:

                //===================== Task Item Product Done  =====================

                SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Stack(children: [
                    Positioned(
                      bottom: 0,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width * .45,
                      child: Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    product.name,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: normalFont(Colors.black, 14),
                                    // ),
                                  ),
                                ),
                                // Spacer(),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * .015,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "\$${product.price}",
                                    style: boldFont(MColors.primaryPurple, 15),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * .035,
                                ),
                              ])),
                    ),
                    Positioned(
                      top: 10,
                      left: MediaQuery.of(context).size.width * .075,
                      width: MediaQuery.of(context).size.width * .3,
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: product.productImage,
                          fit: BoxFit.contain,
                          height: _picHeight,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                          MediaQuery.of(context).size.height / 2,
                        ),
                        tag: product.productID,
                      ),
                    ),
                  ]),
                ),
              );
            }),
      ),
      SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 3.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 15.0,
                  child: RawMaterialButton(
                    onPressed: seeMore,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "See more",
                          style: boldFont(Colors.blueAccent, 14.0),
                        ),
                        SizedBox(width: 3,),
                        Icon(Icons.arrow_forward,size: 18.0,color: Colors.blueAccent,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

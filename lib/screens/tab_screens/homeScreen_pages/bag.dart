import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eShop/model/notifiers/cart_notifier.dart';
import 'package:eShop/model/services/Product_service.dart';
import 'package:eShop/screens/tab_screens/checkout_screens/completeOrder.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class Bag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartNotifier>.value(
      value:  CartNotifier(),
      child: BagScreen(),
    );
  }
}

class BagScreen extends StatefulWidget {
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  Future bagFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    bagFuture = getCart(cartNotifier);
    getCart(cartNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var totalList = cartList.map((e) => e.totalPrice);
    var total = totalList.isEmpty
        ? 0.0
        : totalList.reduce((sum, element) => sum + element).toStringAsFixed(2);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: primaryAppBar(
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MColors.textGrey,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          Text(
            AppLocalizations.of(context).translate('bag')
            ,
            style: boldFont(MColors.primaryPurple, 16.0),
          ),
          MColors.primaryWhiteSmoke,
          null,
          true,
          null,
        ),
        body: FutureBuilder(
          future: bagFuture,
          builder: (c, s) {
            switch (s.connectionState) {
              case ConnectionState.active:
                return progressIndicator(MColors.primaryPurple);
                break;
              case ConnectionState.done:
                return cartList.isEmpty
                    ? emptyScreen(
                        "assets/images/emptyCart.svg",
                  AppLocalizations.of(context).translate('bag is empty')
                        ,
                  AppLocalizations.of(context).translate('products you add to your bag')
                        ,
                      )
                    : bag(cartList, total);
                break;
              case ConnectionState.waiting:
                return progressIndicator(MColors.primaryPurple);
                break;
              default:
                return progressIndicator(MColors.primaryPurple);
            }
          },
        ),
      ),
    );
  }

  Widget bag(cartList, total) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () => getCart(cartNotifier),
        child: primaryContainer(
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartList.length,
                    itemBuilder: (context, i) {
                      var cartItem = cartList[i];

                      return Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (direction) => promptUser(cartItem),
                        onDismissed: (direction) {
                          cartList.remove(UniqueKey());
                          showSimpleSnack(
                            AppLocalizations.of(context).translate('product removed from bag')
                            ,
                            Icons.error_outline,
                            Colors.amber,
                            _scaffoldKey,
                          );
                        },
                        background:
                            backgroundDismiss(AlignmentDirectional.centerStart),
                        secondaryBackground:
                            backgroundDismiss(AlignmentDirectional.centerEnd),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 160.0,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: MColors.primaryWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  width: 80.0,
                                  child: FadeInImage.assetNetwork(
                                    image: cartItem.productImage,
                                    fit: BoxFit.fill,
                                    height: MediaQuery.of(context).size.height,
                                    placeholder:
                                        "assets/images/placeholder.jpg",
                                    placeholderScale:
                                        MediaQuery.of(context).size.height / 2,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          cartItem.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: normalFont(
                                              MColors.textDark, 16.0),
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "\$${cartItem.price}",
                                              style: boldFont(
                                                  MColors.primaryPurple, 22.0),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),














                                      Row(
                                        children: [
                                          Text(

                                            "${AppLocalizations.of(context)
                                                .translate('Quantity')} :",
                                            style: boldFont(MColors.textGrey, 14.0),
                                          ),
                                          SizedBox(width: 10,),
                                          Builder(
                                            builder: (context) {
                                              CartNotifier cartNotifier =
                                              Provider.of<CartNotifier>(context,
                                                  listen: false);

                                              return Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        new BorderRadius.circular(
                                                            10.0),
                                                        color: MColors.primaryPurple,
                                                      ),
                                                      height: 25.0,
                                                      width: 25.0,
                                                      child: RawMaterialButton(
                                                        onPressed: () {
                                                          addAndApdateData(cartItem);
                                                          getCart(cartNotifier);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                          MColors.primaryWhiteSmoke,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Container(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Center(
                                                        child: Text(
                                                          cartItem.quantity.toString(),
                                                          style: normalFont(
                                                              MColors.textDark, 18.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        new BorderRadius.circular(
                                                            10.0),
                                                        color: MColors.primaryWhiteSmoke,
                                                      ),
                                                      width: 25.0,
                                                      height: 25.0,
                                                      child: RawMaterialButton(
                                                        onPressed: () {
                                                          subAndApdateData(cartItem);
                                                          getCart(cartNotifier);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: MColors.primaryPurple,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),










                                      Spacer(),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.redAccent,
                                              size: 14.0,
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Container(
                                              child: Text(
                                                AppLocalizations.of(context).translate('swipe to remove')
                                                ,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: normalFont(
                                                    Colors.redAccent, 10.0),
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
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
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('total'),
                      style: boldFont(MColors.textGrey, 22.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${cartList.length} ${AppLocalizations.of(context).translate('items')}",
                          style: normalFont(MColors.textGrey, 14.0),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "\$$total",
                          style: boldFont(MColors.textGrey, 22.0),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: MColors.primaryWhiteSmoke,
        padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 15.0),
        child: primaryButtonPurple(
          Text(AppLocalizations.of(context).translate('proceed to checkout'),
              style: boldFont(MColors.primaryWhite, 16.0)),
          () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => AddressScreen(cartList),
              ),
            );
          },
        ),
      ),
    );
  }

  //Remove from cart
  Future<bool> promptUser(cartItem) async {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(AppLocalizations.of(context).translate('are you sure you want to remove')),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context).translate('cancel')),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  getCart(cartNotifier);
                },
              ),
              CupertinoDialogAction(
                child: Text( AppLocalizations.of(context).translate('yes')),
                textStyle: normalFont(Colors.red, null),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  removeItemFromCart(cartItem);
                  getCart(cartNotifier);
                },
              ),
            ],
          ),
        ) ??
        false;
  }
}

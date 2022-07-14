import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eShop/model/data/Products.dart';
import 'package:eShop/model/notifiers/cart_notifier.dart';
import 'package:eShop/model/notifiers/products_notifier.dart';
import 'package:eShop/model/services/Product_service.dart';
import 'package:eShop/screens/tab_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/widgets/allWidgets.dart';

class SearchTabWidget extends StatefulWidget {
  final CartNotifier cartNotifier;
  final ProductsNotifier productsNotifier;
  final Iterable<String> cartProdID;
  final Iterable<ProdProducts> prods;

  SearchTabWidget({
    Key key,
    this.cartNotifier,
    this.productsNotifier,
    this.cartProdID,
    this.prods,
  }) : super(key: key);

  @override
  _SearchTabWidgetState createState() => _SearchTabWidgetState(
    cartNotifier,
    productsNotifier,
    cartProdID,
    prods,
  );
}

class _SearchTabWidgetState extends State<SearchTabWidget> {
  _SearchTabWidgetState(
      this.cartNotifier,
      this.productsNotifier,
      this.cartProdID,
      this.prods,
      );
  CartNotifier cartNotifier;
  ProductsNotifier productsNotifier;
  Iterable<String> cartProdID;
  Iterable<ProdProducts> prods;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    double _picHeight;

    if (itemHeight >= 315) {
      _picHeight = itemHeight / 2;
    } else if (itemHeight <= 315 && itemHeight >= 280) {
      _picHeight = itemHeight / 2.2;
    } else if (itemHeight <= 280 && itemHeight >= 200) {
      _picHeight = itemHeight / 2.7;
    } else {
      _picHeight = 30;
    }
    var product;
    List<ProdProducts>.generate(prods.length, (i) {
      var cleanList = prods.toList();
      product = cleanList[i];
      return product;
    });
// ================ Task Search View 1/2 done===================
    return Scaffold(
        key: scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () => getProdProducts(productsNotifier),
          child: primaryContainer(
            GridView.count(
                childAspectRatio: itemWidth / itemHeight,
                crossAxisCount: 2,
                // physics: BouncingScrollPhysics(),
                // itemCount: prods.length,
                children: List<Widget>.generate(
                  prods.length,
                      (i) {
                    var cleanList = prods.toList();
                    var product = cleanList[i];
                    return GestureDetector(
                        onTap: () async {
                          var navigationResult =
                          await Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) =>
                                  ProductDetailsProv(product, prods),
                            ),
                          );
                          if (navigationResult == true) {
                            setState(() {
                              getCart(cartNotifier);
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: i % 2 == 0 ? 20 : 0,
                              right: i % 2 == 0 ? 5 : 0,
                              left: i % 2 == 1 ? 5 : 0,
                              bottom: i % 2 == 1 ? 20 : 0),
                          child:

                          // ================ New Task =======================
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              product.name,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              normalFont(Colors.black, 14),
                                              // ),
                                            ),
                                          ),
                                          // Spacer(),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                .015,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "\$${product.price}",
                                              style: boldFont(
                                                  MColors.primaryPurple, 15),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                .035,
                                          ),
                                        ])),
                              ),
                              Positioned(
                                top: 10,
                                left: MediaQuery.of(context).size.width * .075,
                                width: MediaQuery.of(context).size.width * .3,
                                child: Hero(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: FadeInImage.assetNetwork(
                                      image: product.productImage,
                                      fit: BoxFit.contain,
                                      height: _picHeight,
                                      placeholder:
                                      "assets/images/placeholder.jpg",
                                      placeholderScale:
                                      MediaQuery.of(context).size.height /
                                          2,
                                    ),
                                  ),
                                  tag: product.productID,
                                ),
                              ),
                            ]),
                          ),
                        ));
                  },
                )),
          ),
        ));
  }

  void addToBagshowDialog(
      _product,
      ) async {
    await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              AppLocalizations.of(context).translate('sure you want to add to Bag')
              ,
              style: normalFont(MColors.textDark, null),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context).translate('cancel')
                  ,
                  style: normalFont(Colors.red, null),
                ),
                onPressed: () async {
                  setState(() {
                    getCart(cartNotifier);
                  });
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
                  setState(() {
                    getCart(cartNotifier);
                  });
                  if (cartProdID.contains(_product.productID)) {
                    showSimpleSnack(
                      AppLocalizations.of(context).translate('product already in bag')
                      ,
                      Icons.error_outline,
                      Colors.amber,
                      scaffoldKey,
                    );
                  } else {
                    addProductToCart(_product);
                    showSimpleSnack(
                      AppLocalizations.of(context).translate('product added to bag')
                      ,
                      Icons.check_circle_outline,
                      Colors.green,
                      scaffoldKey,
                    );
                    setState(() {
                      getCart(cartNotifier);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

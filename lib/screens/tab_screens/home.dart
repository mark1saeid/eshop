import 'package:carousel_slider/carousel_slider.dart';
import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eShop/model/data/Products.dart';
import 'package:eShop/model/notifiers/bannerAd_notifier.dart';
import 'package:eShop/model/notifiers/brands_notifier.dart';
import 'package:eShop/model/notifiers/cart_notifier.dart';
import 'package:eShop/model/notifiers/products_notifier.dart';
import 'package:eShop/model/services/Product_service.dart';
import 'package:eShop/screens/tab_screens/homeScreen_pages/brandProductsScreen.dart';
import 'package:eShop/screens/tab_screens/homeScreen_pages/seeMoreScreen.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/internetConnectivity.dart';
import 'package:eShop/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  BrandsNotifier brandsNotifier =
                      Provider.of<BrandsNotifier>(context, listen: false);
                  getBrands(brandsNotifier);

                  ProductsNotifier productsNotifier =
                      Provider.of<ProductsNotifier>(context, listen: false);
                  getProdProducts(productsNotifier);

                  CartNotifier cartNotifier =
                      Provider.of<CartNotifier>(context, listen: false);
                  getCart(cartNotifier);

                  BannerAdNotifier bannerAdNotifier =
                      Provider.of<BannerAdNotifier>(context, listen: false);
                  getBannerAds(bannerAdNotifier);
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageStorageBucket searchBucket = PageStorageBucket();

  //categories
  List<String> categories = ["For You", "Popular","Brands","Offers"];
  int selectedIndex = 0;
  var kTextColor = Color(0xFF535353);
  var kTextLightColor = Color(0xFFACACAC);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
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

    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    // BannerAdNotifier bannerAdNotifier = Provider.of<BannerAdNotifier>(context);
    // var bannerAds = bannerAdNotifier.bannerAdsList;

    BrandsNotifier brandsNotifier = Provider.of<BrandsNotifier>(context);
    var brands = brandsNotifier.brandsList;

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: MColors.primaryWhiteSmoke,
          body: RefreshIndicator(
            onRefresh: () => () async {
              await getProdProducts(productsNotifier);
              await getCart(cartNotifier);
              // await getBannerAds(bannerAdNotifier);
              await getBrands(brandsNotifier);
            }(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BANNER ADS
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 40, left: 15, right: 15),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Text(
                          AppLocalizations.of(context).translate('mainslogn')
                          ,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        )),
                  ),

                  SizedBox(height: 0),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => buildCategory(index),
                    ),
                  ),
                  getCategory(selectedIndex, prods, _picHeight, itemHeight,
                      cartNotifier, cartProdID, productsNotifier, brands)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: selectedIndex == index
                    ? Colors.blueAccent
                    : MColors.lightGrey,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0,bottom: 0), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? Colors.blueAccent
                  : Colors.transparent,
            ),
            SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategory(int index, prods, _picHeight, itemHeight, cartNotifier,
      cartProdID, productsNotifier, brands) {
    //FOR YOU BLOCK
    if (index == 0) {
      return Builder(
        builder: (BuildContext context) {
          Iterable<ProdProducts> forYou = prods.where((e) => e.tag == "forYou");
          var _prods = forYou.toList();

          return blockWigdet(
            AppLocalizations.of(context).translate('FOR YOU')
            ,
            AppLocalizations.of(context).translate('Products you might like')
            ,
            _picHeight,
            itemHeight,
            _prods,
            cartNotifier,
            cartProdID,
            _scaffoldKey,
            context,
            prods,
            () async {
              var title =AppLocalizations.of(context).translate('FOR YOU');
              var navigationResult = await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SeeMoreScreen(
                    title: title,
                    products: _prods,
                    productsNotifier: productsNotifier,
                    cartNotifier: cartNotifier,
                    cartProdID: cartProdID,
                  ),
                ),
              );
              if (navigationResult == true) {
                getCart(cartNotifier);
              }
            },
          );
        },
      );
    }

    if (index == 1) {
      return Builder(
        builder: (BuildContext context) {
          Iterable<ProdProducts> popular =
              prods.where((e) => e.tag == "popular");
          var _prods = popular.toList();

          return blockWigdet(
            AppLocalizations.of(context).translate('POPULAR') ,
            AppLocalizations.of(context).translate('Sought after products') ,
            _picHeight,
            itemHeight,
            _prods,
            cartNotifier,
            cartProdID,
            _scaffoldKey,
            context,
            prods,
            () async {
              var title =
              AppLocalizations.of(context).translate('POPULAR');



              var navigationResult = await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SeeMoreScreen(
                    title: title,
                    products: _prods,
                    productsNotifier: productsNotifier,
                    cartNotifier: cartNotifier,
                    cartProdID: cartProdID,
                  ),
                ),
              );
              if (navigationResult == true) {
                getCart(cartNotifier);
              }
            },
          );
        },
      );
    }

    if (index == 2) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 0.95,
                scrollPhysics: BouncingScrollPhysics(),
              ),
              items: brands.map<Widget>((brand) {
                return Builder(
                  builder: (BuildContext context) {
                    Iterable<ProdProducts> brandList =
                    prods.where((e) => e.brand == brand.brandName);
                    var _prods = brandList.toList();
                    return GestureDetector(
                      onTap: () async {
                        var navigationResult = await Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (context) => BrandProductsScreen(
                                    brand: brand,
                                    products: _prods,
                                    cartNotifier: cartNotifier,
                                    productsNotifier: productsNotifier,
                                    cartProdID: cartProdID,
                                  )),
                        );
                        if (navigationResult == true) {
                          getCart(cartNotifier);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: MColors.primaryWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.03),
                                offset: Offset(0, 10),
                                blurRadius: 10,
                                spreadRadius: 0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Hero(
                            tag: brand.brandName,
                            child: FadeInImage.assetNetwork(
                              image: brand.brandImage,
                              fit: BoxFit.fill,
                              placeholder: "assets/images/placeholder.jpg",
                              placeholderScale:
                                  MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList()
            ),
          ],
        ),
      );
    }

    if (index == 3) //OFFERS
    {
      return Builder(
        builder: (BuildContext context) {
          Iterable<ProdProducts> offers = prods.where((e) => e.tag == "offers");
          var _prods = offers.toList();

          return blockWigdet(
            AppLocalizations.of(context).translate('OFFERS')  ,
            AppLocalizations.of(context).translate('Slashed prices just for you')  ,
            _picHeight,
            itemHeight,
            _prods,
            cartNotifier,
            cartProdID,
            _scaffoldKey,
            context,
            prods,
            () async {
              var title =AppLocalizations.of(context).translate('OFFERS') ;

              var navigationResult = await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SeeMoreScreen(
                    title: title,
                    products: _prods,
                    productsNotifier: productsNotifier,
                    cartNotifier: cartNotifier,
                    cartProdID: cartProdID,
                  ),
                ),
              );
              if (navigationResult == true) {
                getCart(cartNotifier);
              }
            },
          );
        },
      );
    }
  }
}

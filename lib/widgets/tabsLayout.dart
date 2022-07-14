import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../model/notifiers/bannerAd_notifier.dart';
import '../model/notifiers/brands_notifier.dart';
import '../model/notifiers/cart_notifier.dart';
import '../model/notifiers/notifications_notifier.dart';
import '../model/notifiers/orders_notifier.dart';
import '../model/notifiers/products_notifier.dart';
import '../model/notifiers/userData_notifier.dart';
import '../model/services/Product_service.dart';
import '../model/services/pushNotification_service.dart';
import '../model/services/user_management.dart';
import '../screens/tab_screens/history.dart';
import '../screens/tab_screens/home.dart';
import '../screens/tab_screens/homeScreen_pages/bag.dart';
import '../screens/tab_screens/notifications.dart';
import '../screens/tab_screens/search_screens/search_screen.dart';
import '../screens/tab_screens/settings.dart';
import '../utils/colors.dart';
import '../utils/internetConnectivity.dart';
import 'allWidgets.dart';

class TabsLayout extends StatefulWidget {
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;

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

                  UserDataProfileNotifier profileNotifier =
                      Provider.of<UserDataProfileNotifier>(context,
                          listen: false);
                  getProfile(profileNotifier);

                  UserDataAddressNotifier addressNotifier =
                      Provider.of<UserDataAddressNotifier>(context,
                          listen: false);
                  getAddress(addressNotifier);

                  CartNotifier cartNotifier =
                      Provider.of<CartNotifier>(context, listen: false);
                  getCart(cartNotifier);

                  OrderListNotifier orderListNotifier =
                      Provider.of<OrderListNotifier>(context, listen: false);
                  getOrders(orderListNotifier);

                  NotificationsNotifier notificationsNotifier =
                      Provider.of<NotificationsNotifier>(context,
                          listen: false);
                  getNotifications(notificationsNotifier);

                  BannerAdNotifier bannerAdNotifier =
                      Provider.of<BannerAdNotifier>(context, listen: false);
                  getBannerAds(bannerAdNotifier);

                  saveDeviceToken();
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    super.initState();
  }

  final List<Widget> _children = [
    HomeScreen(
      key: PageStorageKey("pageKey1"),
    ),
    HistoryScreen(
      key: PageStorageKey("pageKey2"),
    ),
    InboxScreen(
      key: PageStorageKey("pageKey3"),
    ),
    SettingsScreen(
      key: PageStorageKey("pageKey4"),
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _tabIcons = [
    "assets/images/icons/Home.svg",
    "assets/images/icons/Bookmark.svg",
    "assets/images/icons/Notification.svg",
    "assets/images/icons/Setting.svg",
  ];

  final _appBarTitle = [
    "E Shop",
    "Orders",
    "Notifications",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;

    return Scaffold(
      key: _scaffoldKey,
      appBar: primaryAppBar(
        null,
        _currentIndex != 0
            ? Text(
                _appBarTitle
                    .map((title) {
                      return title;
                    })
                    .where(
                        (title) => _appBarTitle.indexOf(title) == _currentIndex)
                    .toString()
                    .replaceAll("\)", "")
                    .replaceAll("\(", ""),
                style: boldFont(MColors.textGrey, 20.0),
              )
            : Padding(
              padding: const EdgeInsets.only(left: 0,right: 20.0,top: 50.0,bottom: 50.0),
              child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: RawMaterialButton(
                        onPressed: () async {
                          CartNotifier cartNotifier =
                              Provider.of<CartNotifier>(context, listen: false);
                          var navigationResult = await Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => Bag(),
                            ),
                          );
                          if (navigationResult == true) {
                            setState(() {
                              getCart(cartNotifier);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: SvgPicture.asset(
                                  "assets/images/icons/Bag.svg",
                                  height: 25,
                                  color: Colors.black,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: cartList.isNotEmpty
                                        ? Colors.blueAccent
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 7,
                                    minHeight: 7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => Search(),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: MColors.lightGrey),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              )),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/Search.svg",
                                color: Colors.black,
                                height: 20.0,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                AppLocalizations.of(context).translate('search')
                                ,
                                textAlign: TextAlign.left,
                                style: normalFont(MColors.textGrey, 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: PageStorage(
        child: _children[_currentIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: Container(
        color: MColors.primaryWhiteSmoke,
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: MColors.primaryPurple,
          unselectedItemColor: MColors.textGrey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: MColors.primaryWhiteSmoke,
          onTap: onTabTapped,
          items: _tabIcons.map((e) {
            final bool isSelected = _tabIcons.indexOf(e) == _currentIndex;
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        e,
                        height: 22,
                        color: isSelected
                            ? MColors.primaryPurple
                            : MColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text("", style: normalFont(null, 0.0)),
              backgroundColor: MColors.primaryPurple,
            );
          }).toList(),
        ),
      ),
    );
  }
}

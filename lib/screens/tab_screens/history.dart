import 'package:eShop/utils/app_localiztion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eShop/model/data/orders.dart';
import 'package:eShop/model/notifiers/orders_notifier.dart';
import 'package:eShop/model/services/Product_service.dart';
import 'package:eShop/utils/colors.dart';
import 'package:eShop/utils/internetConnectivity.dart';

import 'package:eShop/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  Future ordersFuture;
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _tabItems = [

    "Current orders",

    "Past orders",
  ];

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  OrderListNotifier orderListNotifier =
                      Provider.of<OrderListNotifier>(context, listen: false);
                  ordersFuture = getOrders(orderListNotifier);
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderListNotifier orderListNotifier =
        Provider.of<OrderListNotifier>(context);
    var orderList = orderListNotifier.orderListList;

    return Scaffold(
      body: FutureBuilder(
        future: ordersFuture,
        builder: (c, s) {
          switch (s.connectionState) {
            case ConnectionState.active:
              return progressIndicator(MColors.primaryPurple);
              break;
            case ConnectionState.done:
              return orderList.isEmpty
                  ? emptyScreen(
                      "assets/images/noHistory.svg",
                AppLocalizations.of(context).translate('no orders')
                      ,
                AppLocalizations.of(context).translate('your past orders, transactions and hires will show up here')
                ,
                    )
                  : ordersScreen(orderList);
              break;
            case ConnectionState.waiting:
              return progressIndicator(MColors.primaryPurple);
              break;
            default:
              return progressIndicator(MColors.primaryPurple);
          }
        },
      ),
    );
  }

  Widget ordersScreen(List<OrdersList> orderList) {
   List<OrdersList> deliverdList =[];
   orderList.forEach((e)
   {
     if(e.orderStatus.toString() == "Delivered"){
       deliverdList.add(e);

     }
   }
   );





    final _tabBody = [
      currentOrder(orderList),
      currentOrder(deliverdList),
     // pastOrder(),
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: primaryAppBar(
        null,
        TabBar(
          unselectedLabelColor: MColors.textGrey,
          unselectedLabelStyle: normalFont(MColors.textGrey, 16.0),
          labelColor: MColors.primaryPurple,
          labelStyle: boldFont(MColors.primaryPurple, 20.0),
          indicatorWeight: 0.01,
          isScrollable: true,
          tabs: _tabItems.map((e) {
            return Tab(
              child: Text(
                e,
              ),
            );
          }).toList(),
          controller: _tabController,
        ),
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: primaryContainer(
        TabBarView(
          physics: BouncingScrollPhysics(),
          children: _tabBody,
          controller: _tabController,
        ),
      ),
    );
  }

  Widget currentOrder(List<OrdersList> _orderList) {
 //   OrderListNotifier orderListNotifier = Provider.of<OrderListNotifier>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: _orderList.length,
        itemBuilder: (context, i) {
        //  OrderListNotifier orderListNotifier = Provider.of<OrderListNotifier>(context);
       //   var _orderList = orderListNotifier.orderListList;
_orderList.sort((a, b) => a.orderDate.compareTo(b.orderDate));
          var orderListItem = _orderList[i];
          var orderID = orderListItem.orderID.substring(
            orderListItem.orderID.length - 11,
          );

          var order = _orderList[i].order.toList();
          var orderTotalPriceList = order.map((e) => e['totalPrice']);
          var orderTotalPrice = orderTotalPriceList
              .reduce((sum, element) => sum + element)
              .toStringAsFixed(2);
          var orderDayTime = orderListItem.orderDate.toDate().day.toString() +
              "-" +
              orderListItem.orderDate.toDate().month.toString() +
              "-" +
              orderListItem.orderDate.toDate().year.toString();

          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: MColors.primaryWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate('order no')
                              ,
                              style: normalFont(MColors.textGrey, 14.0),
                            ),
                            Text(
                              orderID,
                              style: boldFont(MColors.textGrey, 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        orderDayTime,
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 70.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 50.0,
                        width: 40.0,
                        child: FadeInImage.assetNetwork(
                          image: order[i]['productImage'],
                          fit: BoxFit.fill,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        order.length.toString() + " Items",
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                      Spacer(),
                      Text(
                        "\$" + orderTotalPrice.toString(),
                        style: boldFont(MColors.textGrey, 14.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 60.0,
                        height: 25.0,
                        child: RawMaterialButton(
                          onPressed: () {
                            _showModalSheet(orderListItem);
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('details')
                            ,
                            style: boldFont(MColors.primaryPurple, 14.0),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        orderListItem.orderStatus,
                        style: boldFont(Colors.green, 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pastOrder() {
    return emptyScreen(
      "assets/images/noHistory.svg",
      AppLocalizations.of(context).translate('no past orders')
      ,
      AppLocalizations.of(context).translate('orders that have been delivered to you or cancelled will show up here')
      ,
    );
  }

  //Order details
  void _showModalSheet(orderListItem) {
    var orderID = orderListItem.orderID.substring(
      orderListItem.orderID.length - 11,
    );
    var order = orderListItem.order.toList();
    var orderTotalPriceList = order.map((e) => e['totalPrice']);
    var orderTotalPrice = orderTotalPriceList
        .reduce((sum, element) => sum + element)
        .toStringAsFixed(2);

    var orderDayTime = orderListItem.orderDate.toDate().day.toString() +
        "-" +
        orderListItem.orderDate.toDate().month.toString() +
        "-" +
        orderListItem.orderDate.toDate().year.toString();

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.9,
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            top: 5.0,
          ),
          padding: EdgeInsets.only(
            bottom: 15.0,
            left: 15.0,
            right: 15.0,
            top: 10.0,
          ),
          decoration: BoxDecoration(
            color: MColors.primaryWhiteSmoke,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                modalBarWidget(),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        AppLocalizations.of(context).translate('order details')
                        ,
                        style: boldFont(MColors.textGrey, 16.0),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "assets/images/icons/Bag.svg",
                        color: MColors.primaryPurple,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$" + orderTotalPrice,
                      style: boldFont(MColors.primaryPurple, 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate('order no')
                              ,
                              style: normalFont(MColors.textGrey, 14.0),
                            ),
                            Text(
                              orderID,
                              style: boldFont(MColors.textGrey, 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        orderDayTime,
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                orderTrackerWidget(orderListItem.orderStatus),
                SizedBox(height: 15.0),
                Text(
                  AppLocalizations.of(context).translate('delivering to')
                  ,
                  style: boldFont(MColors.textGrey, 14.0),
                ),
                SizedBox(height: 5.0),
                Text(
                  orderListItem.shippingAddress,
                  style: normalFont(MColors.textGrey, 14.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.0),
                Container(
                  child: ListView.builder(
                    itemCount: order.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Container(
                        decoration: BoxDecoration(
                          color: MColors.primaryWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 30.0,
                              height: 40.0,
                              child: FadeInImage.assetNetwork(
                                image: order[i]['productImage'],
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height,
                                placeholder: "assets/images/placeholder.jpg",
                                placeholderScale:
                                    MediaQuery.of(context).size.height / 2,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                order[i]['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: normalFont(MColors.textGrey, 14.0),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                color: MColors.dashPurple,
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "X" + order[i]['quantity'].toString(),
                                style: normalFont(MColors.textGrey, 14.0),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                "\$" +
                                    order[i]['totalPrice'].toStringAsFixed(2),
                                style: boldFont(MColors.textDark, 14.0),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

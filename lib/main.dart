
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'model/notifiers/bannerAd_notifier.dart';
import 'model/notifiers/brands_notifier.dart';
import 'model/notifiers/cart_notifier.dart';
import 'model/notifiers/notifications_notifier.dart';
import 'model/notifiers/orders_notifier.dart';
import 'model/notifiers/products_notifier.dart';
import 'model/notifiers/userData_notifier.dart';
import 'model/services/auth_service.dart';
import 'screens/getstarted_screens/intro_screen.dart';
import 'screens/getstarted_screens/splash_screen.dart';
import 'utils/app_localiztion.dart';
import 'utils/colors.dart';
import 'widgets/provider.dart';
import 'widgets/tabsLayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
         return exit(0);
        }

        // Once complete
        if (snapshot.connectionState == ConnectionState.done) {
          return MyProvider(
            auth: AuthService(),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: HomeController(),
            ),
          );
        }
        return SplashScreen();
      },
    );


  }

}

class HomeController extends StatefulWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
@override
  void initState() {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  _fcm.getToken().then((token){
    print(token);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return MaterialApp(
              title: "E Shop",
              theme: ThemeData(
                accentColor: MColors.primaryPurple,
                primaryColor: MColors.primaryPurple,
              ),
              debugShowCheckedModeBanner: false,
              // List all of the app's supported locales here
              supportedLocales: [
                Locale('ar', 'AR'),
                Locale('ar', 'AE'),
                Locale('ar', 'BH'),
                Locale('ar', 'DZ'),
                Locale('ar', 'EG'),
                Locale('ar', 'IQ'),
                Locale('ar', 'JO'),
                Locale('ar', 'KW'),
                Locale('ar', 'LB'),
                Locale('ar', 'LY'),
                Locale('ar', 'MA'),
                Locale('ar', 'OM'),
                Locale('ar', 'QA'),
                Locale('ar', 'SA'),
                Locale('ar', 'SY'),
                Locale('ar', 'TN'),
                Locale('ar', 'YE'),






                Locale('en', 'US'),
                Locale('en', 'AG'),
                Locale('en', 'AI'),
                Locale('en', 'AI'),
                Locale('en', 'BB'),
                Locale('en', 'CA'),
                Locale('en', 'DM'),
                Locale('en', 'IE'),
                Locale('en', 'KR'),
                Locale('en', 'LR'),
                Locale('en', 'PK'),
                Locale('en', 'PH'),
                Locale('en', 'VI'),
                Locale('en', 'ZA'),
                Locale('en', 'GB'),

              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // THIS CLASS WILL BE ADDED LATER
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return supportedLocales.first;
              },
              home: signedIn
                  ? MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(
                          value:ProductsNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:BrandsNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:CartNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:UserDataProfileNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:UserDataAddressNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:OrderListNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:NotificationsNotifier(),
                        ),
                        ChangeNotifierProvider.value(
                          value:BannerAdNotifier(),
                        ),
                      ],
                      child: TabsLayout(),
                    )
                  : IntroScreen(),
            );
          }
          return SplashScreen();
        });
  }
}

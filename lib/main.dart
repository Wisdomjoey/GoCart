import 'package:GOCart/PROVIDERS/auth_provider.dart';
import 'package:GOCart/PROVIDERS/cart_provider.dart';
import 'package:GOCart/PROVIDERS/global_provider.dart';
import 'package:GOCart/PROVIDERS/order_provider.dart';
import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:GOCart/PROVIDERS/shop_provider.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/pages/splash_page.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:provider/provider.dart';

import 'CONSTANTS/constants.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var ios = const DarwinInitializationSettings();
  var initSettings = InitializationSettings(android: android, iOS: ios);

  flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (details) async {
      try {
        if (details.payload == null && details.payload!.isNotEmpty) {
          Get.toNamed(RouteHelper.getRoutePage(), arguments: details.payload);
        } else {}
      } catch (e) {}

      return;
    },
    onDidReceiveBackgroundNotificationResponse: (details) {
      try {
        if (details.payload == null && details.payload!.isNotEmpty) {
        } else {}
      } catch (e) {}

      return;
    },
  );

  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    message.notification!.body.toString(),
    htmlFormatBigText: true,
    contentTitle: message.notification!.title.toString(),
    htmlFormatContentTitle: true,
  );

  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('go_cart', 'go_cart',
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true);

  NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails());

  await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
      message.notification?.body, notificationDetails,
      payload: message.data['payload']);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MyApp(
    dynamicLink: initialLink,
  ));
}

class MyApp extends StatelessWidget {
  final PendingDynamicLinkData? dynamicLink;

  const MyApp({Key? key, this.dynamicLink}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => GlobalProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'GO Cart',
        theme: ThemeData(
          primarySwatch: Constants.primary,
          scaffoldBackgroundColor: Constants.backgroundColor,
          // brightness: Brightness.light
        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark
        // ),
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteHelper.getSplashPage(
            dynamicLink?.link.queryParameters['prodId']),
        getPages: RouteHelper.routes,
        home: SplashPage(
          prodId: dynamicLink?.link.queryParameters['prodId'],
        ),
        // home: const RoutePage(
        //   pageId: 0,
        // ),
      ),
    );
  }
}

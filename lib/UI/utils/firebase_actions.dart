import 'dart:convert';

import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/PROVIDERS/user_provider.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
var ios = const DarwinInitializationSettings();
var initSettings = InitializationSettings(android: android, iOS: ios);

void requestPermission() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('granted');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('granted provisional');
  } else {
    print('declined');
  }
}

void initToken(BuildContext context) async {
  await FirebaseMessaging.instance.getToken().then((value) async {
    await Provider.of<UserProvider>(context, listen: false).updateUserData({
      Constants.userFCMToken: value,
    }, FirebaseAuth.instance.currentUser!.uid);
  });
}

initInfo(RemoteMessage event) async {
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
    event.notification!.body.toString(),
    htmlFormatBigText: true,
    contentTitle: event.notification!.title.toString(),
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

  await flutterLocalNotificationsPlugin.show(0, event.notification?.title,
      event.notification?.body, notificationDetails,
      payload: event.data['payload']);
}

Future sendPushMessage(String token, String title, String body) async {
  // try {
  //   http.Response res = await http.post(
  //     Uri.parse(
  //         'https://fcm.googleapis.com/v1/projects/gocart-b71f6/messages:send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; UTF-8',
  //       'Authorization':
  //           'Bearer AAAAUDNw-so:APA91bE070OAxSTvZ4P2pRUcafEsC6DytqandwGQWIqARjLW1hKbmvewA1KwQ8tkA70__lD2AvNa8s7sAP48yd5VNaVnNm_kkVwEEQD2j6M406pCaDMdRpZsfGQglf878RF7HBefFi6U'
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'status': 'done',
  //           'body': body,
  //           'title': title,
  //           'payload': 4
  //         },
  //         'notification': <String, dynamic>{
  //           'title': title,
  //           'body': body,
  //           'android_channel_id': 'go_cart'
  //         },
  //         'to': token
  //       },
  //     ),
  //   );

  //   return res;
  // } catch (e) {
  //   if (kDebugMode) {}
  // }

  await FirebaseMessaging.instance.sendMessage(
    to: token,
    data: {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'status': 'done',
      'body': body,
      'title': title,
      'payload': '4'
    },
  );
}

Future<Uri> createDynamicLink(String prodId) async {
  var parameters = DynamicLinkParameters(
      link: Uri.parse('https://gomycart.page.link/products?prodId=$prodId'),
      uriPrefix: 'https://gomycart.page.link',
      androidParameters:
          const AndroidParameters(packageName: 'com.example.GOCart'));

  var dynamicLink = await FirebaseDynamicLinks.instance.buildLink(parameters);

  return dynamicLink;
}

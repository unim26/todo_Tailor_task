import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo/core/utils/components/app_snacbar.dart';

class FcmDataService {
  //inti fcm
  Future<String?> initFcm(BuildContext context) async {
    //request permission
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    //get the token
    String? token = await messaging.getToken();

    //handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //notification
      final notification = message.notification;
      if (notification != null) {
        appSnacBar(
          context,
          message: notification.body ?? 'You have a new message',
          snacPosition: SnackPosition.TOP,
          type: 'notification',
        );
      }
    });

    //return
    return token;
  }
}

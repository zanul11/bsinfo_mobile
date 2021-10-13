import 'dart:async';
import 'package:bsainfo_mobile/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplash() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () async {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    startSplash();

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      RemoteNotification? notification = message.notification;
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification!.title.toString()),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body.toString()),
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/bsinfo.png",
              width: (size.height * 0.25),
            ),
          ],
        ),
      ),
    );
  }
}

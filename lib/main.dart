import 'dart:io';

import 'package:bsainfo_mobile/pages/bacamandiri/bacamandiri_form.dart';
import 'package:bsainfo_mobile/pages/bacamandiri/bacamandiri_page.dart';
import 'package:bsainfo_mobile/pages/home/home_page.dart';
import 'package:bsainfo_mobile/pages/login/login_page.dart';
import 'package:bsainfo_mobile/pages/login/profile.dart';
import 'package:bsainfo_mobile/pages/login/register_page.dart';
import 'package:bsainfo_mobile/pages/pengaduan/pengaduan_form.dart';
import 'package:bsainfo_mobile/pages/pengaduan/pengaduan_page.dart';
import 'package:bsainfo_mobile/pages/profile/profile.dart';
import 'package:bsainfo_mobile/pages/splash_page.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'hig_impartance_channel',
  'High Impotance Notofications',
  'This channel is used for important notif',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBAckgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showd up : ${message.messageId}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBAckgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BS INFO ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => Login(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/tagihan': (context) => TagihanPage(),
        // '/tagihan-riwayat': (context) => TagihanRiwayat(),
        // '/tagihan-detail': (context) => TagihanDetail(),
        '/pengaduan': (context) => PengaduanPage(),
        '/pengaduan-form': (context) => PengaduanForm(),
        '/bacamandiri': (context) => BacaMandiriPage(),
        '/bacamandiri-form': (context) => BacaMandiriForm(),
        '/profile-perusahaan': (contex) => ProfilePerusahaanPage(),
      },
    );
  }
}

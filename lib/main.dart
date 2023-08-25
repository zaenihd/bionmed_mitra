// import 'package:bionmed/app/modules/layanan/views/layanan_proses.dart';
// import 'package:bionmed/app/widget/shimmer/shimmer.dart';
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bionmed/app/modules/doctor_app/register/views/register_hospital_view.dart';
import 'package:bionmed/app/modules/doctor_app/splash_screen/views/disclamer.dart';
import 'package:bionmed/app/modules/doctor_app/splash_screen/views/splash_screen_view.dart';
import 'package:bionmed/app/modules/hospital_app/detail_order_hospital/views/detail_order_hospital_view.dart';
import 'package:bionmed/app/modules/hospital_app/edit_profile_hospital/views/edit_profile_hospital_view.dart';
import 'package:bionmed/app/modules/hospital_app/paket_hospital_dan_ambulance/views/paket_hospital_dan_ambulance_view.dart';
import 'package:bionmed/app/modules/hospital_app/register_hospital/views/register_hospital_view.dart';
import 'package:bionmed/app/modules/hospital_app/tambah_tenaga_medis/views/tambah_tenaga_medis_view.dart';
import 'package:bionmed/app/modules/hospital_app/tambah_tenaga_medis_atau_ambulance_in_profile/views/tambah_tenaga_medis_atau_ambulance_in_profile_view.dart';
import 'package:bionmed/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'app/constant/utils.dart';
import 'app/routes/app_pages.dart';
import 'certificate_api.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests'),
      ],
      debug: true);
  ZIMKit().init(
    appID: 1119939175, // your appid
    appSign: Utils().getAppSign, // your appSign
  );
  await GetStorage.init();
  // ignore: unnecessary_new
  HttpOverrides.global = new MyHttpOverrides();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initializeDateFormatting('id_ID', null);

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // // ignore: unused_local_variable
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // String? token = await FirebaseMessaging.instance.getToken();
  // // ignore: unnecessary_brace_in_string_interps
  // print('zezze + ${token}');

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final box = GetStorage();
        var setuju = box.read('dontShowAgain');
        // ignore: prefer_interpolation_to_compose_strings
        print('object' + setuju.toString());
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: "Application",
          // initialRoute: Routes.SPLASH_SCREEN,
          home: setuju == null ? DisclamerSplash() : const SplashScreenView(),
          // initialRoute: Routes.PAKET_LAYANAN_NURSE,
          // home: PaketHospitalDanAmbulanceView(),
          getPages: AppPages.routes,
        );
      },
    ),
  );
}

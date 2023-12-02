import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_news/authentication/authentication.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/route/app_route.dart';
import 'package:flutter_news/views/page/homePage/home_page.dart';
import 'package:flutter_news/views/page/onBoardingPage/on_boarding_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bindings/app_bindings.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDZ-U7czbdxJ_JKXfo84QKo0QsfNlIYUcM",
      appId: "1:875076729657:android:c077d3e0cd511b4878c6e8",
      messagingSenderId: "875076729657",
      projectId: "flutter-news-11f8f",
    ),
  );
  initializeNotification();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  ));
  await hiveInit();
  runApp(const MyApp());
}

Future<void> hiveInit() async {
  var directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.toString());
  Hive.registerAdapter(NewsModelAdapter());
  Hive.registerAdapter(SourceAdapter());

  await Hive.openBox<NewsModel>("saved_news");
}

Future<void> initializeNotification() async {
  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  bool? isInitializedNotifications =
      await notificationsPlugin.initialize(initializationSettings);

  log("isInitializedNotifications $isInitializedNotifications");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    print(Get.height);
    print(Get.width);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
        splashColor: Colors.white,
      ),
      onInit: () => FlutterNativeSplash.remove(),
      initialBinding: AppBindings(),
      initialRoute:
          AuthService.isLOggedIn() ? AppRoute.home : AppRoute.onboardingPage,
      getPages: AppRoute().appRoutes(),
    );
  }

  Widget selectHomeScreen() {
    return AuthService.isLOggedIn() ? const HomePage() : OnboardingPage();
  }
}

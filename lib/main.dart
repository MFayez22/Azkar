import 'dart:math';

import 'package:azkar/conestant/colors/colors.dart';
import 'package:azkar/conestant/staticVar.dart';
import 'package:azkar/conestant/themes/themes.dart';
import 'package:azkar/layout/home/cubit/cubit.dart';
import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/layout/home/home_screen.dart';
import 'package:azkar/modules/splash_screen/splash_screen.dart';
import 'package:azkar/network/dio_helper/dio_helper.dart';
import 'package:azkar/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  Workmanager().registerOneOffTask("task-identifier", "simpleTask");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// theme

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  int themeNum = sharedPreferences.getInt('themeData') ?? 1;

  /// notification
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  /// notification end
  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();

  runApp(MyApp(themeNum: themeNum,));
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}

class MyApp extends StatelessWidget {
  int themeNum;
   MyApp({Key? key, required this.themeNum}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarHomeCubit()
        ..getDateTime()
        ..checkIsFirstTime()
        ..getAllAzkarMusic()
        ..getAllAyat()
        ..getUrlPage()
        ..getThemeData()
        ..getThemeData(),
      child: BlocConsumer<AzkarHomeCubit, AzkarState>(
        listener: (context, state) {
          // if (state is AzkarGetLocationPermissionSuccessState) {
          //   AzkarHomeCubit.get(context).getCurrentLocation2();
          // }
          // if (state is AzkarGetLocationSuccessState) {
          //   AzkarHomeCubit.get(context).getWeather(
          //       lon: '${AzkarHomeCubit.get(context).longitude}',
          //       lat: '${AzkarHomeCubit.get(context).latitude}');
          // }
        },
        builder: (context, state) {
          // AzkarHomeCubit.get(context).getCurrentLocation();
          return MaterialApp(
            title: 'Azkar',
            debugShowCheckedModeBanner: false,
            theme: themeNum == 1
                ? themeData11(context)
                : themeNum == 2
                    ? themeData22(context)
                    : themeData33(context),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) {
    showNotification();
    return Future.value(true);
  });
}

Future showNotification() async {
  int randomIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '1.0',
    'Azkar',
    'تطبيق اذكار وادعية ',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.show(
    1,
    'فَذَكِّرْ',
    StaticVars().smallDo3a2[randomIndex],
    platformChannelSpecifics,
  );
}

/// theme

Future<void> getThemeData() async {
  if (CacheHelper.getThemeData(key: 'themeData') == 1) {
    backgroundColor = theme0Color1;
    background2Color = theme0Color4;
    background3Color = theme0Color2;
    containerColor = theme0Color1;
    container2Color = theme0Color4;
    container3Color = theme0Color2;
    textColor = theme0Color1;
    text2Color = theme0Color4;
    text3Color = theme0Color2;

    themeData = themeData1;
  }
  if (CacheHelper.getThemeData(key: 'themeData') == 2) {
    backgroundColor = theme1Color1;
    background2Color = theme1Color4;
    background3Color = theme1Color2;
    containerColor = theme1Color1;
    container2Color = theme1Color4;
    container3Color = theme1Color2;
    textColor = theme1Color1;
    text2Color = theme1Color4;
    text3Color = theme1Color2;

    themeData = themeData2;
  }

  if (CacheHelper.getThemeData(key: 'themeData') == 3) {
    backgroundColor = theme2Color1;
    background2Color = theme2Color4;
    background3Color = theme2Color2;
    containerColor = theme2Color1;
    container2Color = theme2Color4;
    container3Color = theme2Color2;
    textColor = theme2Color1;
    text2Color = theme2Color4;
    text3Color = theme2Color2;

    themeData = themeData3;
  }
}

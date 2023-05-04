import 'package:azkar/layout/home/cubit/cubit.dart';
import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/layout/home/home_screen.dart';
import 'package:azkar/network/dio_helper/dio_helper.dart';
import 'package:azkar/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();
  runApp(const MyApp());
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarHomeCubit()
        ..getDateTime()
        ..checkIsFirstTime()
        ..getAllAzkarMusic()
        ..getAllAyat()
        ..getUrlPage(),
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
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.deepOrange),
                titleSpacing: 0.0,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

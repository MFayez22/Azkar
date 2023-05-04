import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/models/urlPage_model.dart';
import 'package:azkar/network/dio_helper/dio_helper.dart';
import 'package:azkar/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../conestant/weather_screen.dart';
import '../../../models/ayat_model.dart';
import '../../../models/azkar_music_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AzkarHomeCubit extends Cubit<AzkarState> {
  AzkarHomeCubit() : super(AzkarInitialState());

  static AzkarHomeCubit get(context) => BlocProvider.of(context);

  var locationMessage = '';
  double latitude = 0;
  double longitude = 0;

  List<Map> weatheList = [];
  String cityName = '';
  String weatherDescription = '';
  String temp = '';
  String weatherIconCode = '';



  void changeFirstTime() {
    CacheHelper().setData(key: 'isFirstTime', value: false).then((value) {
      emit(IsNOtFirstTimeState());
    });
  }

  void checkIsFirstTime() {
    if (CacheHelper().getData(key: 'isFirstTime') == null) {
      CacheHelper().setData(key: 'isFirstTime', value: true).then((value) {
        emit(IsFirstTimeState());
        print('null IsFirstTimeState');
      });

    }
    if (CacheHelper().getData(key: 'isFirstTime') == true) {
      CacheHelper().setData(key: 'isFirstTime', value: true).then((value) {
        emit(IsFirstTimeState());
        print('IsFirstTimeState');
      });

    }
    if (CacheHelper().getData(key: 'isFirstTime') == false) {
      CacheHelper().setData(key: 'isFirstTime', value: false).then((value) {
        emit(IsNOtFirstTimeState());
        print('IsNOtFirstTimeState');
      });

    }
  }

  void checkLocationPermision() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      emit(LocationServiceDisEnabledState());
    }
  }

  void getCurrentLocation2() async {
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
      getWeather2(
          lat: value.latitude.toString(), long: value.longitude.toString());
    });
    // getWeather(lat: '${position.latitude}', lon: '${position.longitude}');

    // emit(AzkarGetLocationSuccessState());
  }

  void getWeather2({required String lat, required String long}) async {
    List weatherMap = [];
    await DioHelper.getData(url: 'data/2.5/weather?', query: {
      'lon': long,
      'lat': lat,
      'lang': 'ar',
      'appid': '7400b51ec88cb732985453d0492ee3a9',
    }).then((value) {
      print(value.data['name']);
      cityName = value.data['name'];
      weatherDescription = value.data['weather'][0]['description'];
      temp = NumberFormat('###.0#', 'en_US')
          .format((value.data['main']['temp'] - 273))
          .toString();
      weatherIconCode = value.data['weather'][0]['icon'];
      print('sdasdsa************************');
      emit(AzkarGetWeatherState());
    });
  }

  Future getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
            forceAndroidLocationManager: true,
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // getWeather(lat: '${latitude}', lon: '${longitude}');
      // getWeather(lat: '${value.latitude}', lon: '${value.longitude}');
      latitude = value.latitude;
      longitude = value.longitude;
      emit(AzkarGetLocationSuccessState());
    });

    // getWeather(lat: '${latitude}', lon: '${longitude}');

    var lastPosition = await Geolocator.getLastKnownPosition();

    print(position.latitude);
    print(position.longitude);
    // latitude = position.latitude;
    // longitude = position.longitude;
  }

  void getWeather() async {
    emit(AzkarLoadingGetWeatherState());

    DioHelper.getData(url: 'data/2.5/weather?', query: {
      'lon': '30.926450',
      'lat': '30.470344',
      'lang': 'ar',
      'appid': '5fb088ad923c2d90494d6d2a1aab67a7',
    }).then((value) {
      // print(value.data['main']['temp']);
      // print(value.data['name']);
      // print(value.data['weather'][0]['description']);
      // print(value.data['weather'][0]['icon']);

      cityName = value.data['name'];
      weatherDescription = value.data['weather'][0]['description'];
      // temp = (value.data['main']['temp'] - 273).roundToDouble().toString();
      temp = NumberFormat('###.0#', 'en_US')
          .format((value.data['main']['temp'] - 273))
          .toString();

      weatherIconCode = value.data['weather'][0]['icon'];

      emit(AzkarGetWeatherState());
    }).catchError((error) {});
  }

  Future checkPemissionLocatiom() async {
    var locationStatus = await Permission.location.status;

    print(locationStatus);

    if (!locationStatus.isGranted) {
      await Permission.location.request().then((value) {
        emit(AzkarGetLocationPermissionSuccessState());
      });
      // await Permission.locationWhenInUse.request();
      // await Permission.locationAlways.request();
    } else {
      emit(AzkarGetLocationPermissionSuccessState());
    }
  }

  String? nameTW = 'الله اكبر';
  int? numTW = 0;

  void changeNameTW({required String currentName}) {
    nameTW = currentName;
    numTW = 0;
    emit(AzkarChangeNameTW());
  }

  void changeNumTW() {
    numTW = numTW! + 1;

    emit(AzkarChangeNumTW());
  }

  String changeWeatherIcon() {
    String weatherIconName = 'lib/images/weatherIcon/01d.png';
    switch (weatherIconCode) {
      case '01d':
        {
          weatherIconName = 'lib/images/weatherIcon/01d.png';
        }
        break;
      case '01n':
        {
          weatherIconName = 'lib/images/weatherIcon/01n.png';
        }
        break;
      case '02d':
        {
          weatherIconName = 'lib/images/weatherIcon/02d.png';
        }
        break;
      case '02n':
        {
          weatherIconName = 'lib/images/weatherIcon/02n.png';
        }
        break;
      case '03d':
        {
          weatherIconName = 'lib/images/weatherIcon/03d.png';
        }
        break;
      case '03n':
        {
          weatherIconName = 'lib/images/weatherIcon/03d.png';
        }
        break;
      case '04d':
        {
          weatherIconName = 'lib/images/weatherIcon/04d.png';
        }
        break;
      case '04n':
        {
          weatherIconName = 'lib/images/weatherIcon/04d.png';
        }
        break;
      case '09d':
        {
          weatherIconName = 'lib/images/weatherIcon/09d.png';
        }
        break;
      case '09n':
        {
          weatherIconName = 'lib/images/weatherIcon/09d.png';
        }
        break;
      case '10d':
        {
          weatherIconName = 'lib/images/weatherIcon/10d.png';
        }
        break;
      case '10n':
        {
          weatherIconName = 'lib/images/weatherIcon/10d.png';
        }
        break;
      case '11d':
        {
          weatherIconName = 'lib/images/weatherIcon/11d.png';
        }
        break;
      case '11n':
        {
          weatherIconName = 'lib/images/weatherIcon/11d.png';
        }
        break;
      case '50d':
        {
          weatherIconName = 'lib/images/weatherIcon/50d.png';
        }
        break;
      case '50n':
        {
          weatherIconName = 'lib/images/weatherIcon/50d.png';
        }
        break;
    }
    return weatherIconName;
  }

  String date = '';
  String time = '';

  Future getDateTime() async {
    date = DateFormat.MMMMEEEEd().format(DateTime.now());
    time = DateFormat.Hm().format(DateTime.now());
    emit(AzkarChangeDateTime());
  }

  List<AyatModel> ayatModel = [];

  void getAllAyat() {
    emit(AzkarGetAyatLoadingState());
    FirebaseFirestore.instance.collection('ayat').get().then((value) {
      ayatModel = [];
      value.docs.forEach((element) {
        ayatModel.add(AyatModel.fromJson(element.data()));
      });

      emit(AzkarGetAyatSuccessState());
    }).catchError((error) {
      emit(AzkarGetAyatErrorState());
    });
  }

  List<AzkarMusicModel> azkarMusicList = [];

  void getAllAzkarMusic() {
    FirebaseFirestore.instance
        .collection('azkarMusicList')
        .orderBy('id')
        .get()
        .then((value) {
      azkarMusicList = [];
      value.docs.forEach((element) {
        azkarMusicList.add(AzkarMusicModel.fromJson(element.data()));
      });

      emit(AzkarGetAzkarMusicSuccessState());
    }).catchError((error) {
      emit(AzkarGetAzkarMusicErrorState());
    });
  }

  bool isLast = false;

  void changePage(var pageViewController) async {
    await delay(3);
    pageViewController.nextPage(
        duration: Duration(milliseconds: 1), curve: Curves.easeIn);
    emit(AzkarChangeTitleSuccessState());
  }

  void changePage1(var pageViewController) async {
    await delay(1);
    pageViewController.jumpToPage(0);
    emit(AzkarChangeTitleSuccessState());
  }

  Future<void> delay(int minutes) async {
    print('delay started');
    await Future.delayed(Duration(minutes: minutes));
    print('end started');
  }

  String time2 = '';
  bool isMorning = true;

  void checkIsMorning() {
    time2 = DateFormat.H().format(DateTime.now());

    if (int.parse(time2) >= 12) {
      if (int.parse(time2) <= 23) isMorning = false;
    } else {
      isMorning = true;
    }
  }

  UrlPageModel? urlPage;

  void getUrlPage() {
    FirebaseFirestore.instance
        .collection('urlPage')
        .doc('urlPage')
        .get()
        .then((value) {
      urlPage = UrlPageModel.fromJson(value.data()!);
    });
  }

  void facebookPage({required final String urlPage}) async {
    // final url = urlPage;
    if (await canLaunch(urlPage)) {
      await launch(
        urlPage,
        forceWebView: true,
        forceSafariVC: true,
        enableJavaScript: true,
      );
    }
  }
}

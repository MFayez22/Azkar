import 'package:azkar/conestant/themes/themes.dart';
import 'package:azkar/layout/home/cubit/cubit.dart';
import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/lists/lists.dart';
import 'package:azkar/modules/azkarMusic_screen/azkarMusic_screen.dart';
import 'package:azkar/modules/azkar_list/azkar_list_screen.dart';
import 'package:azkar/modules/azkar_three/azkar_three_list_screen.dart';
import 'package:azkar/modules/azkar_two/azkar_two_list_screen.dart';
import 'package:azkar/modules/settings_screen/settings_screen.dart';
import 'package:azkar/network/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/ayat_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  var pageViewController = PageController();
  var titlePageViewController = PageController();
  String cityName = '';
  String weatherDescription = '';

  // temp = (value.data['main']['temp'] - 273).roundToDouble().toString();
  String temp = '';
  String weatherIconCode = '';

  Color titleColor = Colors.orange;
  String titleIcon = 'lib/images/icons/sun.png';
  List titleList = morningTitleList;

  bool isActiveLocation = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarHomeCubit()
        ..getDateTime()
        ..checkIsFirstTime()
        ..getAllAyat()
        ..getAllAzkarMusic()
        ..getUrlPage()
        ..checkIsMorning()
      ,
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

          // if (state is IsFirstTimeState) {
          //   showDialog(
          //       context: context,
          //       builder: (context) => Dialog(
          //               child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Card(
          //                     color: Colors.blue.shade800,
          //                     clipBehavior: Clip.hardEdge,
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(10.0)),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(10.0),
          //                       child: Text(
          //                         'يجمع هذا التطبيق بيانات الموقع لتمكين من معرفة حالة الطقس حتى في حالة إغلاق التطبيق أو عدم استخدامه ". ',
          //                         style: TextStyle(
          //                             fontSize: 20.0, color: Colors.white),
          //                       ),
          //                     )),
          //                 SizedBox(
          //                   height: 20.0,
          //                 ),
          //                 Align(
          //                   alignment: AlignmentDirectional.bottomEnd,
          //                   child: MaterialButton(
          //                     onPressed: () {
          //                       AzkarHomeCubit.get(context).changeFirstTime();
          //                       AzkarHomeCubit().getCurrentLocation2();
          //                       Navigator.pop(context);
          //                     },
          //                     color: Colors.blue.shade800,
          //                     child: Text(
          //                       'موافق',
          //                       style: TextStyle(color: Colors.white),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           )));
          // }
        },
        builder: (context, state) {
          // AzkarHomeCubit.get(context).getCurrentLocation();
          // AzkarHomeCubit.get(context).getCurrentLocation2();
          // getCurrentLocation(context: context);
          AzkarHomeCubit.get(context).getAllAyat();
          AzkarHomeCubit.get(context).getDateTime();
          // if (!AzkarHomeCubit.get(context).isLast) {
          //   AzkarHomeCubit.get(context).changePage(titlePageViewController);
          // }
          // if (AzkarHomeCubit.get(context).isLast) {
          //   AzkarHomeCubit.get(context).changePage1(titlePageViewController);
          // }
          if (!AzkarHomeCubit.get(context).isMorning) {
            titleColor = Colors.blue.shade900;
            titleIcon = 'lib/images/icons/moon.png';
            titleList = nightTitleList;
          }
          AzkarHomeCubit.get(context).getUrlPage();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: background2Color,
              // title: Builder(
              //   builder: (context) => Padding(
              //     padding: const EdgeInsetsDirectional.only(start: 15.0),
              //     child: Text(
              //       'Azkar',
              //       style: TextStyle(
              //         color: Colors.deepOrange,
              //       ),
              //     ),
              //   ),
              // ),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(
                        Icons.segment,
                        color: Colors.deepOrange,
                      )),
                ),
              ],
            ),
            endDrawer: Drawer(
                child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          backgroundColor,
                          background3Color,
                        ]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Image.asset(
                        'lib/images/icons/eclipse.png',
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Azkar | اذكار ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: text2Color),
                      ),
                      Text(
                        'رضيتُ بالله ربًّا، وبالإسلام دينًا، وبمحمدٍ ﷺ نبيًّا',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: text2Color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الصفحة الرئيسية',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.home_outlined,
                          color: containerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AzkarListScreen(
                                    list: nightList,
                                    titleName: 'اذكار المساء',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'اذكار المساء',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.nights_stay_outlined,
                          color: containerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AzkarListScreen(
                                    list: morningList,
                                    titleName: 'اذكار الصباح',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'اذكار الصباح',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: containerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AzkarListScreen(
                                    titleName: 'جوامع الدعاء',
                                    list: gwamaEldoaa,
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'جوامع الدعاء',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.mosque_outlined,
                          color: containerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15.0),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: container3Color,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الإعدادات',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.settings,
                          color: containerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () {
                      AzkarHomeCubit().facebookPage(
                          urlPage:
                              AzkarHomeCubit.get(context).urlPage!.urlPage!);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Facebook Page',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.facebook_outlined,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  background2Color,
                  backgroundColor,
                ],
              )),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        // weather
                        Container(
                          width: double.infinity,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            color: container2Color,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade50,
                                  Colors.white,
                                ],
                              )),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${AzkarHomeCubit.get(context).cityName}',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${AzkarHomeCubit.get(context).time}    ${AzkarHomeCubit.get(context).date}',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Image.asset(
                                          '${AzkarHomeCubit.get(context).changeWeatherIcon()}',
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                        Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${AzkarHomeCubit.get(context).temp} °C',
                                                style: TextStyle(
                                                    color: Colors.orange[600],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                'درجة الحرارة',
                                                style: TextStyle(
                                                  color: Colors.blue[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${AzkarHomeCubit.get(context).weatherDescription}',
                                                style: TextStyle(
                                                    color: Colors.orange[600],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                'حالة الطقس',
                                                style: TextStyle(
                                                  color: Colors.blue[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          AzkarHomeCubit.get(context)
                                              .getCurrentLocation2();
                                          AzkarHomeCubit.get(context)
                                              .getDateTime();
                                          AzkarHomeCubit.get(context)
                                              .getWeather2(
                                                  lat: AzkarHomeCubit.get(
                                                          context)
                                                      .latitude
                                                      .toString(),
                                                  long: AzkarHomeCubit.get(
                                                          context)
                                                      .longitude
                                                      .toString());
                                        },
                                        splashColor: Colors.blue,
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.deepOrange,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        //title of Azkar
                        Container(
                          height: 150,
                          width: double.infinity,
                          child: Card(
                            color: titleColor,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(titleIcon, height: 80.0),
                                        Spacer(),
                                        SmoothPageIndicator(
                                          controller: titlePageViewController,
                                          count: morningTitleList.length,
                                          effect: ExpandingDotsEffect(
                                            dotColor: Colors.grey,
                                            activeDotColor: Colors.white,
                                            dotHeight: 8,
                                            expansionFactor: 3,
                                            dotWidth: 8,
                                            spacing: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: PageView.builder(
                                        itemBuilder: (context, index) =>
                                            titlePageView(titleList, index),
                                        itemCount: morningTitleList.length,
                                        controller: titlePageViewController,
                                        onPageChanged: (index) {
                                          if (index == morningList.length - 1) {
                                            AzkarHomeCubit.get(context).isLast =
                                                true;
                                          } else {
                                            AzkarHomeCubit.get(context).isLast =
                                                false;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        // list of Azkar

                        Row(
                          children: [
                            //اذكار المساء
                            Expanded(
                              child: Container(
                                height: 150,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  splashColor: containerColor,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AzkarListScreen(
                                                  list: nightList,
                                                  titleName: 'اذكار المساء',
                                                )));
                                  },
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 100.0,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Card(
                                            color: container2Color,
                                            shadowColor: containerColor,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(bottom: 20.0),
                                                  child: Text(
                                                    'اذكار المساء',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: CircleAvatar(
                                            backgroundColor:containerColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'lib/images/icons/moon.png',
                                              ),
                                            ),
                                            radius: 40.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),

                            //اذكار الصباح
                            Expanded(
                              child: Container(
                                height: 150,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  splashColor: backgroundColor,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AzkarListScreen(
                                                  list: morningList,
                                                  titleName: 'اذكار الصباح',
                                                )));
                                  },
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 100.0,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Card(
                                            color: container2Color,
                                            shadowColor: backgroundColor,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(bottom: 20.0),
                                                  child: Text(
                                                    'اذكار الصباح',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: CircleAvatar(
                                            backgroundColor: containerColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'lib/images/icons/sun.png',
                                              ),
                                            ),
                                            radius: 40.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // جوامع الدعاء
                        SizedBox(
                          height: 10.0,
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(30.0),
                          splashColor: backgroundColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AzkarListScreen(
                                          list: gwamaEldoaa,
                                          titleName: 'جوامع الدعاء',
                                        )));
                          },
                          child: Container(
                            height: 150,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    child: Card(
                                      color: containerColor,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(bottom: 20.0),
                                            child: Text(
                                              'جوامع الدعاء',
                                              style: TextStyle(
                                                color: text2Color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: CircleAvatar(
                                    radius: 43.0,
                                    backgroundColor: background2Color,
                                    child: CircleAvatar(
                                        backgroundColor: containerColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'lib/images/icons/praying.png',
                                          ),
                                        ),
                                        radius: 40.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),

                        // list 2 of azkar


                        Row(
                          children: [
                            // اذكار المسجد
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                splashColor: backgroundColor,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AzkarThreeListScreen(
                                                list: masgidList,
                                                titleName: 'اذكار المسجد',
                                              )));
                                },
                                child: Container(
                                  height: 150,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 100.0,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Card(
                                            color: container2Color,
                                            shadowColor: backgroundColor,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(bottom: 20.0),
                                                  child: Text(
                                                    'اذكار المسجد',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: CircleAvatar(
                                            backgroundColor: containerColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'lib/images/icons/mosque.png',
                                              ),
                                            ),
                                            radius: 40.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),

                            // تسابيح
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                splashColor: backgroundColor,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AzkarTwoListScreen(
                                                list: tsabihList,
                                                titleName: 'تسابيح',
                                              )));
                                },
                                child: Container(
                                  height: 150,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 100.0,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Card(
                                            color: container2Color,
                                            shadowColor: backgroundColor,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(bottom: 20.0),
                                                  child: Text(
                                                    'تسابيح',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: CircleAvatar(
                                            backgroundColor: containerColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'lib/images/icons/tasbih.png',
                                              ),
                                            ),
                                            radius: 40.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // الاذكار صوت
                        InkWell(
                          borderRadius: BorderRadius.circular(30.0),
                          splashColor: backgroundColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AudioPlayersScreen(
                                          list: AzkarHomeCubit.get(context)
                                              .azkarMusicList,
                                          titleName: 'الاذكار صوت',
                                        )));
                          },
                          child: Container(
                            height: 150,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    child: Card(
                                      color: containerColor,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(bottom: 20.0),
                                            child: Text(
                                              'الاذكار صوت',
                                              style: TextStyle(
                                                color: text2Color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: CircleAvatar(
                                    radius: 43.0,
                                    backgroundColor: container2Color,
                                    child: CircleAvatar(
                                        backgroundColor: containerColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'lib/images/icons/azkarMusic.png',
                                          ),
                                        ),
                                        radius: 40.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        // المسبحة الالكترونية
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: container2Color),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 20.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 27.0,
                                      backgroundColor: container2Color,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        child: Image.asset(
                                            'lib/images/icons/tasbih.png'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'المسبحة الالكترونية',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            background3Color,
                                            background2Color,
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    AzkarHomeCubit.get(context)
                                                        .changeNameTW(
                                                            currentName:
                                                                'الله اكبر ');
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  color: containerColor,
                                                  child: Text(
                                                    'الله اكبر ',
                                                    style: TextStyle(
                                                      color: text2Color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    AzkarHomeCubit.get(context)
                                                        .changeNameTW(
                                                            currentName:
                                                                ' سبحان الله');
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  color: containerColor,
                                                  child: Text(
                                                    ' سبحان الله',
                                                    style: TextStyle(
                                                      color: text2Color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    AzkarHomeCubit.get(context)
                                                        .changeNameTW(
                                                            currentName:
                                                                'الحمد لله');
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  color:containerColor,
                                                  child: Text(
                                                    'الحمد لله',
                                                    style: TextStyle(
                                                      color: text2Color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: CircleAvatar(
                                              radius: 33.0,
                                              backgroundColor: container2Color,
                                              child: CircleAvatar(
                                                radius: 30.0,
                                                child: Text(
                                                  '${AzkarHomeCubit.get(context).numTW}',
                                                  style: TextStyle(
                                                    color: text2Color,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed: () {
                                                AzkarHomeCubit.get(context)
                                                    .changeNumTW();
                                              },
                                              elevation: 5.0,
                                              height: 60.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              color: containerColor,
                                              child: Text(
                                                  '${AzkarHomeCubit.get(context).nameTW}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: text2Color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'بلغوا عني ولو آية',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 27.0,
                                      backgroundColor: container2Color,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        child: Image.asset(
                                            'lib/images/icons/quran.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 300,
                                child: PageView.builder(
                                  itemBuilder: (context, index) => pageViewItem(
                                      AzkarHomeCubit.get(context)
                                          .ayatModel[index]),
                                  itemCount: AzkarHomeCubit.get(context)
                                      .ayatModel
                                      .length,
                                  physics: BouncingScrollPhysics(),
                                  controller: pageViewController,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  SmoothPageIndicator(
                                    controller: pageViewController,
                                    count: AzkarHomeCubit.get(context)
                                        .ayatModel
                                        .length,
                                    effect: ExpandingDotsEffect(
                                      dotColor: Colors.grey,
                                      activeDotColor: containerColor,
                                      dotHeight: 10,
                                      expansionFactor: 4,
                                      dotWidth: 10,
                                      spacing: 5,
                                    ),
                                  ),
                                  Spacer(),
                                  FloatingActionButton(
                                    onPressed: () {
                                      pageViewController.nextPage(
                                          duration: Duration(milliseconds: 900),
                                          curve: Curves.slowMiddle);
                                    },
                                    child: Icon(Icons.navigate_next),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titlePageView(List list, int index) {
    return Center(
      child: Text(
        list[index]['title'],
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }

  Widget pageViewItem(AyatModel ayatModel) {
    return Card(
      color: container2Color,
      clipBehavior: Clip.hardEdge,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                container3Color,
                containerColor,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
              end: 20.0, top: 10.0, bottom: 10.0, start: 10.0),
          child: Center(
            child: Text(
              ayatModel.name!,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: text2Color,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentLocation({required BuildContext context}) async {
    var position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
    // AzkarHomeCubit.get(context)
    //     .getWeather(lon: '${position.longitude}', lat: '${position.latitude}');

    // var lastPosition = await Geolocator.getLastKnownPosition();
  }

  void getWeather() async {
    List weatherMap = [];
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
      temp = (value.data['main']['temp'] - 273).roundToDouble().toString();
      // temp = NumberFormat('###.0#', 'en_US')
      //     .format((value.data['main']['temp'] - 273))
      //     .toString();

      weatherIconCode = value.data['weather'][0]['icon'];
      weatherMap = value.data;
    }).catchError((error) {});
  }
}

import 'package:azkar/conestant/colors/colors.dart';
import 'package:azkar/conestant/themes/themes.dart';
import 'package:azkar/layout/home/cubit/cubit.dart';
import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/modules/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return BlocProvider<AzkarHomeCubit>(
      create: (context) => AzkarHomeCubit(),
      child: BlocConsumer<AzkarHomeCubit, AzkarState>(
        listener: (context, state) {
          if (state is ChangeThemesDataState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false);
          }
if(state is SaveNotificationChangeState)
{
  key.currentState!.showSnackBar(
      new SnackBar(content: new Text("تم حفظ التغيرات",textAlign: TextAlign.center),));
}
        },
        builder: (context, state) {
          return Scaffold(
            key: key,
            appBar: AppBar(
              backgroundColor: background2Color,
              centerTitle: true,
              title: Text(
                'الإعدادات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.white,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'choose theme',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: text3Color),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          AzkarHomeCubit.get(context)
                                              .changeThemesIcon(numTheme: 1);
                                        },
                                        color: theme0Color1,
                                      ),
                                      Text(
                                        'Orange',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme0Color1),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          child: AzkarHomeCubit.get(context)
                                                  .isChoose1
                                              ? Icon(
                                                  Icons.done_outline,
                                                  color: Colors.green,
                                                )
                                              : SizedBox(
                                                  height: 10.0,
                                                )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          AzkarHomeCubit.get(context)
                                              .changeThemesIcon(numTheme: 2);
                                        },
                                        color: theme1Color1,
                                      ),
                                      Text(
                                        'Blue',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme1Color1),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          child: AzkarHomeCubit.get(context)
                                                  .isChoose2
                                              ? Icon(
                                                  Icons.done_outline,
                                                  color: Colors.green,
                                                )
                                              : SizedBox(
                                                  height: 10.0,
                                                )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          AzkarHomeCubit.get(context)
                                              .changeThemesIcon(numTheme: 3);
                                        },
                                        color: theme2Color1,
                                      ),
                                      Text(
                                        'Green',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: theme2Color1),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          child: AzkarHomeCubit.get(context)
                                                  .isChoose3
                                              ? Icon(
                                                  Icons.done_outline,
                                                  color: Colors.green,
                                                )
                                              : SizedBox(
                                                  height: 10.0,
                                                )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                onPressed: () {
                                  AzkarHomeCubit.get(context).setTheme();
                                },
                                color: container2Color,
                                child: Text(
                                  'save',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// notification
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'الاشعارات',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.white,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Switch(
                                    value: AzkarHomeCubit.get(context)
                                        .switchValue1,
                                    activeColor: Colors.green,
                                    onChanged: (value)
                                    {
                                      AzkarHomeCubit.get(context).changeSwitchValue1();
                                    }),
                                Spacer(),
                                Text(
                                  'تفعيل اشعارات الاذكار ',
                                  style:
                                      TextStyle(fontSize: 18, color: textColor),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Switch(
                                    value: AzkarHomeCubit.get(context)
                                        .switchValue2,
                                    activeColor: Colors.green,
                                    onChanged: (value)
                                    {
                                      AzkarHomeCubit.get(context).changeSwitchValue2();
                                    }),
                                Spacer(),
                                Text(
                                  'تفعيل اشعارات الصباح و المساء ',
                                  style:
                                  TextStyle(fontSize: 18, color: textColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  AzkarHomeCubit.get(context).saveNotificationChange();

                                },
                                color: container2Color,
                                child: Text(
                                  'save',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

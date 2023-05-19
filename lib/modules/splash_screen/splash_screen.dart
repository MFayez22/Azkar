import 'package:azkar/conestant/colors/colors.dart';
import 'package:azkar/conestant/themes/themes.dart';
import 'package:azkar/layout/home/cubit/cubit.dart';
import 'package:azkar/layout/home/cubit/state.dart';
import 'package:azkar/layout/home/home_screen.dart';
import 'package:azkar/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AzkarHomeCubit>(
      create: (context) => AzkarHomeCubit()..getThemeData(),
      child: BlocConsumer<AzkarHomeCubit, AzkarState>(
        listener: (context, state) {
          if (state is GetThemesDataState) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => HomeScreen()), (
                    route) => false);
          }

          // if(state is UIdIsEmptyState)
          // {
          //   Navigator.pushAndRemoveUntil(
          //       context, MaterialPageRoute(
          //       builder: (context) =>
          //           LoginScreen()), (
          //       route) => false);
          // }
          // if(state is LoginAsAdminSuccessState)
          // {
          //   Navigator.pushAndRemoveUntil(
          //       context, MaterialPageRoute(
          //       builder: (context) =>
          //           AdminHomeScreen()), (
          //       route) => false);
          //
          // }
          // if(state is LoginAsAdminErrorState)
          // {
          //
          //   Navigator.pushAndRemoveUntil(
          //       context, MaterialPageRoute(
          //       builder: (context) =>
          //           HomeScreen()), (
          //       route) => false);
          // }
        },
        builder: (context, state) {
          // AzkarHomeCubit.get(context).getThemeData();

          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.orange.shade600,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150,),

                  Center(
                    child: Container(
                      height: 150,
                      child: Lottie.asset('lib/images/sunmoon.json',
                          height: 100,
                          reverse: true,
                          repeat: true,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'اللهم ارحم أمواتنا وأموات المسلمين',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Image.asset(
                        'lib/images/icons/eclipse.png',
                        height: 60,
                        width: 60,
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        'Azkar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'by MFayez',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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

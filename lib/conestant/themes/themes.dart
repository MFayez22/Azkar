import 'package:azkar/conestant/colors/colors.dart';

import 'package:flutter/material.dart';


ThemeData themeData = themeData1;

ThemeData themeData1 = ThemeData(

  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    // color: theme0Color2,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.deepOrange),
    titleSpacing: 0.0,
  ),
  scaffoldBackgroundColor: theme0Color4,
);

ThemeData themeData2 = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    color: theme1Color2,
    elevation: 0.0,
    iconTheme: IconThemeData(color:theme1Color1),
    titleSpacing: 0.0,
  ),
  scaffoldBackgroundColor:  theme1Color4,
);

ThemeData themeData3 = ThemeData(
  primarySwatch: Colors.green,
  appBarTheme: AppBarTheme(
    color: theme2Color2,
    elevation: 0.0,
    iconTheme: IconThemeData(color:theme2Color1),
    titleSpacing: 0.0,
  ),
  scaffoldBackgroundColor:  theme2Color4,
);

// app colors theme

// Color backgroundColor = theme0Color1;

Color backgroundColor = theme0Color1;
Color background2Color = theme0Color4;
Color background3Color = theme0Color2;
Color containerColor = theme0Color1;
Color container2Color =theme0Color4;
Color container3Color = theme0Color2;
Color textColor = theme0Color1;
Color text2Color = theme0Color4;
Color text3Color =theme0Color2;

ThemeData themeData11(BuildContext context) {
  return ThemeData(

    primarySwatch: Colors.deepOrange,
    appBarTheme: AppBarTheme(
      // color: theme0Color2,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.deepOrange),
      titleSpacing: 0.0,
    ),
    scaffoldBackgroundColor: theme0Color4,
  );
}

ThemeData themeData22(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      color: theme1Color2,
      elevation: 0.0,
      iconTheme: IconThemeData(color:theme1Color1),
      titleSpacing: 0.0,
    ),
    scaffoldBackgroundColor:  theme1Color4,
  );
}

ThemeData themeData33(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      color: theme2Color2,
      elevation: 0.0,
      iconTheme: IconThemeData(color:theme2Color1),
      titleSpacing: 0.0,
    ),
    scaffoldBackgroundColor:  theme2Color4,
  );
}

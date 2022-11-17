import 'package:flutter/material.dart';

var theme = ThemeData(

    appBarTheme: AppBarTheme(
        color: Colors.white,
        centerTitle: false,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
        actionsIconTheme: IconThemeData(color: Colors.black)
    ),
    textTheme: TextTheme(
        bodyText2: TextStyle(color: Colors.grey)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 2,
        selectedItemColor: Colors.black
    )

);
import 'package:flutter/material.dart';

class BlinkThemes {
  ThemeData? blinkmainTheme() {
    return ThemeData(
        iconTheme: const IconThemeData(color: Color(0xff37523f)),
        textTheme: const TextTheme(
          labelMedium: TextStyle(color: Color(0xff37523f)),
          labelLarge: TextStyle(color: Color(0xff37523f)),
          bodyLarge: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Color(0xff3a6047),
          selectedIconTheme: IconThemeData(color: Color(0xff2fc086)),
          unselectedIconTheme: IconThemeData(color: Color(0xff2fc086)),
        ),
        /*
            cardTheme:
            CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            */
        useMaterial3: true);
  }
}

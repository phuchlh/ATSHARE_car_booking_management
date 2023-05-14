import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4dabf7);
const errColor = Color(0xffFF1F3D);
const backgroundColor2 = Color(0xFF17203A);
const secondaryBackground = Color.fromARGB(255, 255, 255, 255);
const primaryBackground = Color.fromARGB(255, 255, 255, 255);
const primaryText = Color.fromARGB(255, 0, 0, 0);
const loading = Color.fromARGB(255, 196, 193, 11);

const shimmerBase = Color.fromARGB(255, 189, 189, 197);
const shimmerHighlight = Color(0xFFF2F2F6);

const styleTextNormal = TextStyle(fontWeight: FontWeight.w400);
const dontHave = 'Không có';
const double defaultPadding = 20.0;
const double defaultFontSize = 14.0;
const double defaultBorder = 8.0;
/* regex: 
11C -> true,
10C -> false,
1C -> false,
1 -> true, 
11 -> true, 
111 -> true, 
1111 -> true, 
11111 -> true, 
111111 -> false */

enum LoadingState {
  initial,
  loading,
  success,
  failed,
}

final ThemeData themeData = ThemeData(
  primaryColor: Color(0xFF4dabf7),
);
final MaterialColor primarySwatch = MaterialColor(
  0xFFB39DDB,
  const <int, Color>{
    50: Colors.white,
    100: Color(0xFFF3E5F5),
    200: Color(0xFFE1BEE7),
    300: Color(0xFFCE93D8),
    400: Color(0xFFBA68C8),
    500: Color(0xFFAB47BC),
    600: Color(0xFF9C27B0),
    700: Color(0xFF8E24AA),
    800: Color(0xFF7B1FA2),
    900: Color(0xFF6A1B9A),
  },
);

// stupid constant

const String ERROR_PHOTO = "https://i.imgur.com/YIcWBqg.jpeg";
    // "https://www.autocubana.com/assets/default_car-83e7841ce1a818a032ca9b6976bc3ddd51db34b92b646b4ddf5882dc66e2c089.jpg";

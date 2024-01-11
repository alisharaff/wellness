import 'package:flutter/material.dart';

import 'light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: false,
    primaryColor: buildMaterialColor(const Color.fromRGBO(6, 65, 61, 1.0)),
    cardTheme: const CardTheme(color: LightColor.background),
    iconTheme: const IconThemeData(color: LightColor.iconColor),
    dividerColor: LightColor.grey,
    colorScheme: ColorScheme.fromSeed(
      seedColor: buildMaterialColor(const Color.fromRGBO(6, 65, 61, 1.0)),
      onPrimary: buildMaterialColor(const Color.fromRGBO(6, 65, 61, 1.0)),
      brightness: Brightness.light,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: LightColor.background),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

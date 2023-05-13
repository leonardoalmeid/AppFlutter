import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    darkTheme: ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      hintColor: Colors.white,
      dividerColor: Colors.black12,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: Color(0xFF212121)),
    ),
    themeMode: ThemeMode.dark,
    routes: {
      // '/buscarGifs': (context) => BuscarGifsScreen(),
    },
  ));
}

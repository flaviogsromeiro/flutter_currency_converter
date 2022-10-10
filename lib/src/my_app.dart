import 'package:flutter/material.dart';

import 'home/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().copyWith().colorScheme.copyWith(
              primary: const Color(0xFFFFD600),
            ),
        textTheme: ThemeData().copyWith().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              bodyMedium: const TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}

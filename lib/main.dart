import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 61, 88, 158),
          secondary: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: const HomePage(),
    );
  }
}

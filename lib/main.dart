import 'package:flutter/material.dart';
import 'package:onstream/Screens/landing_page.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/home_screen.dart';
import 'package:flutter_movie/services/api_service.dart';

void main() {
  ApiService().getPopulars();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_list/page/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

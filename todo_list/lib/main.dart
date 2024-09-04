import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/controller/pageControl.dart';
import 'package:todo_list/page/splashScreen.dart';

void main() {
  Get.put(NoteController());
  Get.put(HomePageController());
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

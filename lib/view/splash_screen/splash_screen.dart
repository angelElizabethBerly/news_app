// ignore_for_file: prefer_const_constructors

import 'package:api_with_provider/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff2c5),
      body: Center(
        child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLRHxwmPcJOtBnRtVw-MkWAtE6EW06NQvl6ML1QNp2q392hsluhMX8KwvjgQ&s"),
        // child: Text(
        //   "NewsApp",
        //   style: TextStyle(fontSize: 30),
        // ),
      ),
    );
  }
}

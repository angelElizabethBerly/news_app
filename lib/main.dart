import 'package:api_with_provider/controller/favourite_screen_controller.dart';
import 'package:api_with_provider/controller/home_screen_controller.dart';
import 'package:api_with_provider/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeScreenController()),
      ChangeNotifierProvider(create: (context) => FavouriteScreenController())
    ], child: MaterialApp(home: SplashScreen()));
  }
}

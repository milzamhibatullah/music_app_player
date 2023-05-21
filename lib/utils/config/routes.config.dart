import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app_player/view/home.screen.view.dart';

///manage all navigation routes here
class AppRoutes {
  ///define static const route name below
  static const String home = '/';
  static const String musicDetail ='/music-detail';



  ///generate route function that returns Route<dynamic>
  ///Apply this function onGenerateRoutes
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

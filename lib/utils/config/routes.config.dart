import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/view/home.screen.view.dart';
import 'package:music_app_player/view/music/music.detail.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

///manage all navigation routes here
///use this class when you want to create new page or screen
class AppRoutes {
  ///define static const route name below
  static const String home = '/';
  static const String musicDetail = '/music-detail';

  ///generate route function that returns Route<dynamic>
  ///Apply this function onGenerateRoutes
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/music-detail':
        ///use cupertino page route to get transition sliding from bottom to top
        return CupertinoPageRoute(
            builder: (_) =>  MusicDetail(), fullscreenDialog: true);
      default:
        /// place to another screen if route is not defined
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

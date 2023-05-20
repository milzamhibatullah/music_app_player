import 'package:flutter/material.dart';
import 'package:music_app_player/utils/config/routes.config.dart';

void main() {
  runApp( MaterialApp(
    initialRoute: AppRoutes.home,
    onGenerateRoute: AppRoutes.generateRoutes,
  ),);
}

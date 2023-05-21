import 'package:flutter/material.dart';
import 'package:music_app_player/utils/config/routes.config.dart';
import 'package:music_app_player/utils/theme/app.theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
    theme: AppTheme.lightData(),
    darkTheme: AppTheme.darkData(),
    initialRoute: AppRoutes.home,
    onGenerateRoute: AppRoutes.generateRoutes,
  ),);
}

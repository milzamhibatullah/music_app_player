import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/utils/config/routes.config.dart';
import 'package:music_app_player/utils/theme/app.theme.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

void main() {
  ///implement widget flutter binding to bridge the plugin that need native
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ///define all bloc process here
    MultiBlocProvider(
      providers: [
        /// run function init when bloc create at first
        BlocProvider<MusicBloc>(create: (_)=>MusicBloc()..init())
      ],
      child: MaterialApp(
        theme: AppTheme.lightData(),
        darkTheme: AppTheme.darkData(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoutes,
      ),
    ),
  );
}

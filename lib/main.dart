import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/utils/config/routes.config.dart';
import 'package:music_app_player/utils/theme/app.theme.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MusicBloc>(create: (_)=>MusicBloc())
      ],
      child: MaterialApp(
        theme: AppTheme.lightData(),
        darkTheme: AppTheme.darkData(),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoutes,
      ),
    ),
  );
}

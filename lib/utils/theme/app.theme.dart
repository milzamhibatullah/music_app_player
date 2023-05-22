import 'package:flutter/material.dart';

///this class to manage all about themes in app
///check readme.md for generate link
class AppTheme {
  ///define lightColorScheme
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF4953BE),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE0E0FF),
    onPrimaryContainer: Color(0xFF000569),
    secondary: Color(0xFF764B9B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFF1DAFF),
    onSecondaryContainer: Color(0xFF2D004F),
    tertiary: Color(0xFF824790),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFCD6FF),
    onTertiaryContainer: Color(0xFF340042),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF3A0B00),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF3A0B00),
    surfaceVariant: Color(0xFFE3E1EC),
    onSurfaceVariant: Color(0xFF46464F),
    outline: Color(0xFF777680),
    onInverseSurface: Color(0xFFFFEDE8),
    inverseSurface: Color(0xFF5D1800),
    inversePrimary: Color(0xFFBEC2FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4953BE),
    outlineVariant: Color(0xFFC7C5D0),
    scrim: Color(0xFF000000),
  );

  ///define darkColorScheme
  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBEC2FF),
    onPrimary: Color(0xFF131D8F),
    primaryContainer: Color(0xFF2F39A5),
    onPrimaryContainer: Color(0xFFE0E0FF),
    secondary: Color(0xFFDFB7FF),
    onSecondary: Color(0xFF451969),
    secondaryContainer: Color(0xFF5D3282),
    onSecondaryContainer: Color(0xFFF1DAFF),
    tertiary: Color(0xFFF3AEFF),
    onTertiary: Color(0xFF4F155E),
    tertiaryContainer: Color(0xFF682E76),
    onTertiaryContainer: Color(0xFFFCD6FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF3A0B00),
    onBackground: Color(0xFFFFDBD0),
    surface: Color(0xFF3A0B00),
    onSurface: Color(0xFFFFDBD0),
    surfaceVariant: Color(0xFF46464F),
    onSurfaceVariant: Color(0xFFC7C5D0),
    outline: Color(0xFF91909A),
    onInverseSurface: Color(0xFF3A0B00),
    inverseSurface: Color(0xFFFFDBD0),
    inversePrimary: Color(0xFF4953BE),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFBEC2FF),
    outlineVariant: Color(0xFF46464F),
    scrim: Color(0xFF000000),
  );

  ///define light theme color scheme
  static ThemeData lightData() {
    return ThemeData( useMaterial3:true,colorScheme: _lightColorScheme);
  }

  ///define dark theme color scheme
  static ThemeData darkData() {
    return ThemeData(useMaterial3: true, colorScheme: _darkColorScheme);
  }
}

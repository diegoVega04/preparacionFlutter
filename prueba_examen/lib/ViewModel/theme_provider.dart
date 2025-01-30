import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  double _fontSize = 16.0; // Tamaño de letra inicial
  bool _isDarkMode = false; // Estado del tema

  ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: _fontSize, color: Colors.black),
          bodyMedium: TextStyle(fontSize: _fontSize, color: Colors.black),
          bodySmall: TextStyle(fontSize: _fontSize, color: Colors.black),
        ),
      );

  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: _fontSize, color: Colors.white),
          bodyMedium: TextStyle(fontSize: _fontSize, color: Colors.white),
          bodySmall: TextStyle(fontSize: _fontSize, color: Colors.white),
        ),
      );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeText(double size) {
    _fontSize = size;
    notifyListeners();
  }
}
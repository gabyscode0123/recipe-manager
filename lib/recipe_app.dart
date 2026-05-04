import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme/tuscan_theme.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Manager',
      debugShowCheckedModeBanner: false,
      theme: buildTuscanTheme(Brightness.light),
      darkTheme: buildTuscanTheme(Brightness.dark),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        isDark: _isDark,
        toggleTheme: () => setState(() => _isDark = !_isDark),
      ),
    );
  }
}

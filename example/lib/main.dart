import 'package:flutter/material.dart';
import 'package:yako_theme_switch/yako_theme_switch.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black),
      themeMode: themeMode,
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YakoThemeSwitch(
                enabled: themeMode == ThemeMode.light,
                onChanged: ({bool? changed}) {
                  if (changed != null) {
                    setState(() {
                      themeMode = changed ? ThemeMode.light : ThemeMode.dark;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

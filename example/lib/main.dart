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
      home: GestureDetector(
        onTap: () {
          setState(() {
            themeMode =
                themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          });
        },
        child: Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 4,
                  child: YakoThemeSwitch(
                    enabled: themeMode == ThemeMode.light,
                    onChanged: ({bool? changed}) {
                      if (changed != null) {
                        setState(() {
                          themeMode =
                              changed ? ThemeMode.light : ThemeMode.dark;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

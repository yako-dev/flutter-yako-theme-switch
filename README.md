# Yako Theme Switch

Just a cool switch for your app's theme

<p align="center">
  <img src="https://github.com/yako-dev/flutter-yako-theme-switch/blob/main/assets/showcase_animation.gif?raw=true">
</p>


## Installing:
In your pubspec.yaml
```yaml
dependencies:
  yako_theme_switch: ^1.0.0
```
<br>

## Basic Usage:
```dart
    YakoThemeSwitch(
      enabled: themeMode == ThemeMode.light,
      onChanged: ({bool? changed}) {},
    );
```
## Advanced usage
```dart
    YakoThemeSwitch(
      enabled: themeMode == ThemeMode.light,
      onChanged: ({bool? changed}) {},
      width: 50,
      enabledBackgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.red,
      enabledToggleColor: Colors.white,
      disabledToggleColor: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      enabledToggleBorderRadius: 8,
    ),
```

<br>


## Check out other Yako packages:

[Badges](https://pub.dev/packages/badges)

[Settings UI](https://pub.dev/packages/settings_ui)

[Status Alert](https://pub.dev/packages/status_alert)

[Full Screen Menu](https://pub.dev/packages/full_screen_menu)

[Diagonal decoration](https://pub.dev/packages/diagonal_decoration) 

and more to come!

# Yako Theme Switch

Just a cool switch for your app's theme

<p align="center">
  <img src="https://github.com/yako-dev/flutter-yako-theme-switch/blob/main/assets/showcase_animation.gif?raw=true">
</p>


## Installing:
Requirements: Flutter 3.47+ (`material_ui`). On older Flutter, use `yako_theme_switch: ^2.0.1`.

In your pubspec.yaml
```yaml
dependencies:
  yako_theme_switch: ^3.0.0
```
<br>

## Basic Usage:
```dart
    YakoThemeSwitch(
      enabled: themeMode == ThemeMode.light,
      onChanged: (bool value) {
        setState(() => themeMode = value ? ThemeMode.light : ThemeMode.dark);
      },
    );
```
## Advanced usage
```dart
    YakoThemeSwitch(
      enabled: themeMode == ThemeMode.light,
      onChanged: (bool value) {
        setState(() => themeMode = value ? ThemeMode.light : ThemeMode.dark);
      },
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


<!-- more-from-yako:start -->
## More from Yako

Other Flutter packages from the same team:

<table>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/settings_ui"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/settings_ui.gif" width="220" alt="Animated demo of the settings_ui Flutter package: an iOS-style settings screen with Appearance and General sections; turning on Dark mode switches the whole list to dark."></a><br>
      <a href="https://pub.dev/packages/settings_ui"><b>settings_ui</b></a><br>
      <sub>Settings screens that look native on every platform.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/badges"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/badges.gif" width="220" alt="Animated demo of the badges Flutter package: a count badge on a cart icon goes from 1 to 4, a notification badge pops in, and a Twitter-style verified badge, a NEW label and an Instagram-shaped badge appear."></a><br>
      <a href="https://pub.dev/packages/badges"><b>badges</b></a><br>
      <sub>Badges for any widget: counters, dots, shapes and animations.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/yako_celebrations"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/yako_celebrations.webp" width="220" alt="Animated demo of the yako_celebrations Flutter package: an epic celebration fills a dark screen with fireworks, flames, spinning coins, confetti and popping Yako logos under a LEVEL UP! title."></a><br>
      <a href="https://pub.dev/packages/yako_celebrations"><b>yako_celebrations</b></a><br>
      <sub>Full-screen celebrations in one line: confetti, coins, fireworks, flames.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/status_alert"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/status_alert.gif" width="220" alt="Animated demo of the status_alert Flutter package: liking a song shows an Apple-style blurred Loved popup with an icon and a subtitle, which then fades away."></a><br>
      <a href="https://pub.dev/packages/status_alert"><b>status_alert</b></a><br>
      <sub>Apple-style status alerts that hide themselves.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/full_screen_menu"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/full_screen_menu.gif" width="220" alt="Animated demo of the full_screen_menu Flutter package: a blurred full-screen overlay opens over a weather app with five round gradient buttons and a close button."></a><br>
      <a href="https://pub.dev/packages/full_screen_menu"><b>full_screen_menu</b></a><br>
      <sub>A full-screen menu with round gradient buttons.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/diagonal_decoration"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/diagonal_decoration.png" width="220" alt="Screenshot of the diagonal_decoration Flutter package: one card filled with fine diagonal lines (DiagonalDecoration) and one with a curved line mesh (MatrixDecoration)."></a><br>
      <a href="https://pub.dev/packages/diagonal_decoration"><b>diagonal_decoration</b></a><br>
      <sub>Diagonal-line and mesh backgrounds for boxes.</sub>
    </td>
  </tr>
</table>
<!-- more-from-yako:end -->

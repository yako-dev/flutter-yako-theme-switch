## [3.0.0] - [Unreleased]

### Breaking Changes
* Migrated to `package:material_ui`. Flutter 3.47 moved Material out of the
  SDK into the `material_ui` package, so the switch now imports
  `package:material_ui/material_ui.dart` instead of
  `package:flutter/material.dart` and depends on `material_ui: ^1.4.0`. The
  switch reads nothing from the Material theme (Material only supplies its
  two default colors, `Colors.grey.shade300` and `Colors.amberAccent.shade700`),
  so nothing visible changes, whether your app uses `material_ui` or still
  uses `package:flutter/material.dart`. No `MaterialUiCompatibilityBridge` is
  needed.
* Minimum SDK raised to Dart 3.13.0 / Flutter 3.47.0 (from Dart 3.4.0 /
  Flutter 3.27.0). Apps on older Flutter keep resolving the previous major,
  2.x (2.0.1).

### Maintenance
* The example app and the tests import `package:material_ui` too.

## [2.0.1] - [September 25, 2026]

### Fixes
* New `enabledBackgroundColor`, `disabledBackgroundColor`, `enabledToggleColor`
  and `disabledToggleColor` values from the parent are now applied. They were
  read only once, when the switch was created.
* A new `animationDuration` from the parent is now used.
* Right-to-left layouts: the switch is now mirrored, with the dark side on the
  right. Before, the light-mode thumb was drawn outside the track.
* Screen readers now announce the switch and whether it is on or off.
* The internal `CurvedAnimation` is now disposed.
* Apps no longer bundle the 685 KB README animation
  (`assets/showcase_animation.gif`). Only the moon icon is declared as an asset.

### Maintenance
* Added `analysis_options.yaml` with `flutter_lints`. The package listed
  `flutter_lints` but never applied it.
* The library exports `src/yako_theme_switch.dart` instead of
  `../src/yako_theme_switch.dart`.
* Removed the unused `mocktail` dev dependency.
* Added pub.dev topics: `widget`, `switch`, `theme`, `dark-mode`.
* Added `.pubignore` and refreshed `.gitignore`.
* CI: replaced the Very Good workflows with a CI workflow (analyze, format
  check and tests on stable, a non-blocking beta job and a weekly run), a PR
  title check, and a publish workflow that uses pub.dev automated publishing
  (OIDC) with the Flutter SDK. The old publish workflow used Node 20 actions.
* Example: fixed the `onChanged` callback, which no longer compiled with
  2.0.0, and regenerated the platform folders so the app builds with current
  Flutter, Gradle and Xcode.

### Tests
* Added regression tests for parent color and duration changes, RTL layout,
  toggled semantics and animation disposal.

## [2.0.0] - [Apr 9, 2026]

### Improvements
* Added `super.key` to constructor — widgets can now be identified by key.
* State class fields are now private (`_animationController`, `_turnState`, etc.).
* `createState` uses `State<YakoThemeSwitch>` return type annotation.
* `const Color(...)` used for default color literals.
* Removed redundant `addPostFrameCallback` animation trigger in `initState` — eliminates a visual flash on initial render.
* `onChanged` callback is now called outside `setState`, following Flutter best practices.
* Replaced bare `Container` with `SizedBox` for the toggle hit area (semantic clarity).

### Dependency Updates
* `flutter_svg` bumped from `^2.0.7` to `^2.2.3`
* `mocktail` bumped from `^0.3.0` to `^1.0.4`
* `flutter_lints` bumped from `^2.0.0` to `^6.0.0`
* Minimum Flutter SDK raised from `>=3.10.0` to `>=3.27.0`
* Minimum Dart SDK raised from `>=3.0.0` to `>=3.4.0`

### Tests
* Replaced empty/commented test suite with 11 widget tests covering:
  rendering, default state, enabled state, tap callbacks, external prop
  updates, custom width, custom colors, custom duration, border radius,
  key support, and multi-tap alternation.

## [1.0.0+1] - [Jul 9, 2023]
* First release

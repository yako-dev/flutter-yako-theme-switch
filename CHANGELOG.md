## [2.0.0] - [Apr 9, 2026]

### Breaking Changes
* `onChanged` callback signature changed from `Function({bool changed})` to `ValueChanged<bool>` (i.e. `void Function(bool)`).
  Migrate: `onChanged: ({bool? changed}) {}` → `onChanged: (bool value) {}`

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
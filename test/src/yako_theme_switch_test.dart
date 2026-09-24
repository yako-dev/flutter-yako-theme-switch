import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yako_theme_switch/yako_theme_switch.dart';

void main() {
  group('YakoThemeSwitch', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('starts in disabled (dark) state by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // enabled defaults to false — widget should be present and stable
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('starts in enabled (light) state when enabled: true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              enabled: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('calls onChanged with true when tapped from disabled state',
        (tester) async {
      bool? received;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              enabled: false,
              onChanged: (value) => received = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(received, isTrue);
    });

    testWidgets('calls onChanged with false when tapped from enabled state',
        (tester) async {
      bool? received;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              enabled: true,
              onChanged: (value) => received = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(received, isFalse);
    });

    testWidgets('responds to external enabled prop change via didUpdateWidget',
        (tester) async {
      bool switchEnabled = false;
      bool? callbackValue;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    YakoThemeSwitch(
                      enabled: switchEnabled,
                      onChanged: (value) {
                        callbackValue = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => switchEnabled = true),
                      child: const Text('Enable'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
      // callbackValue not set — external prop change does not call onChanged
      expect(callbackValue, isNull);
    });

    testWidgets('accepts custom width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              width: 80,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('accepts custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              enabledBackgroundColor: Colors.blue,
              disabledBackgroundColor: Colors.red,
              enabledToggleColor: Colors.green,
              disabledToggleColor: Colors.purple,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('accepts custom animationDuration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              animationDuration: const Duration(milliseconds: 100),
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('accepts custom enabledToggleBorderRadius', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              enabledToggleBorderRadius: 4,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(YakoThemeSwitch), findsOneWidget);
    });

    testWidgets('accepts a key', (tester) async {
      const key = Key('theme_switch');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              key: key,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('can be tapped multiple times alternating state',
        (tester) async {
      final received = <bool>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(
              onChanged: received.add,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(received, [true, false, true]);
    });
    testWidgets('uses new colors passed by the parent', (tester) async {
      Widget build(Color background) => MaterialApp(
            home: Scaffold(
              body: YakoThemeSwitch(
                enabled: true,
                enabledBackgroundColor: background,
                onChanged: (_) {},
              ),
            ),
          );

      const Color blue = Color(0xFF2196F3);
      const Color red = Color(0xFFF44336);

      await tester.pumpWidget(build(blue));
      expect(_trackColor(tester), isSameColorAs(blue));

      await tester.pumpWidget(build(red));
      expect(_trackColor(tester), isSameColorAs(red));
    });

    testWidgets('uses a new animationDuration passed by the parent',
        (tester) async {
      Widget build({required Duration duration, required bool enabled}) =>
          MaterialApp(
            home: Scaffold(
              body: YakoThemeSwitch(
                enabled: enabled,
                animationDuration: duration,
                onChanged: (_) {},
              ),
            ),
          );

      await tester.pumpWidget(
        build(duration: const Duration(seconds: 1), enabled: false),
      );
      await tester.pumpWidget(
        build(duration: const Duration(milliseconds: 100), enabled: false),
      );
      await tester.pumpWidget(
        build(duration: const Duration(milliseconds: 100), enabled: true),
      );
      await tester.pump(const Duration(milliseconds: 150));

      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('reports its toggled state to accessibility services',
        (tester) async {
      final SemanticsHandle semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: YakoThemeSwitch(onChanged: (_) {}),
          ),
        ),
      );
      expect(
        tester.getSemantics(find.byType(YakoThemeSwitch)),
        isSemantics(
          hasToggledState: true,
          isToggled: false,
          hasTapAction: true,
        ),
      );

      await tester.tap(find.byType(YakoThemeSwitch));
      await tester.pumpAndSettle();
      expect(
        tester.getSemantics(find.byType(YakoThemeSwitch)),
        isSemantics(hasToggledState: true, isToggled: true),
      );

      semantics.dispose();
    });

    for (final TextDirection textDirection in TextDirection.values) {
      testWidgets(
          'keeps the thumb inside the track in ${textDirection.name} layouts',
          (tester) async {
        final bool rtl = textDirection == TextDirection.rtl;
        for (final bool enabled in <bool>[false, true]) {
          await tester.pumpWidget(
            Directionality(
              textDirection: textDirection,
              child: Center(
                child: YakoThemeSwitch(enabled: enabled, onChanged: (_) {}),
              ),
            ),
          );
          await tester.pumpAndSettle();

          final Rect track = tester.getRect(find.byType(YakoThemeSwitch));
          final Offset thumb = tester.getCenter(_thumb);
          expect(thumb.dx, greaterThanOrEqualTo(track.left + 9));
          expect(thumb.dx, lessThanOrEqualTo(track.right - 9));
          // Dark (false) sits on the start side: left in LTR, right in RTL.
          final bool thumbOnRight = thumb.dx > track.center.dx;
          expect(thumbOnRight, enabled != rtl, reason: 'enabled: $enabled');
        }
      });
    }

    testWidgets('disposes the animations it creates', (tester) async {
      final Set<Object> created = <Object>{};
      final Set<Object> disposed = <Object>{};
      void listener(ObjectEvent event) {
        if (event is ObjectCreated) created.add(event.object);
        if (event is ObjectDisposed) disposed.add(event.object);
      }

      FlutterMemoryAllocations.instance.addListener(listener);
      addTearDown(
        () => FlutterMemoryAllocations.instance.removeListener(listener),
      );

      await tester.pumpWidget(
        MaterialApp(home: YakoThemeSwitch(onChanged: (_) {})),
      );
      await tester.pumpWidget(const SizedBox());

      final List<Animation<Object?>> leaked =
          created.difference(disposed).whereType<Animation<Object?>>().toList();
      expect(leaked, isEmpty);
    });
  });
}

Color? _trackColor(WidgetTester tester) {
  final Container track = tester.widget<Container>(
    find
        .descendant(
          of: find.byType(YakoThemeSwitch),
          matching: find.byType(Container),
        )
        .first,
  );
  return (track.decoration as BoxDecoration?)?.color;
}

final Finder _thumb = find
    .descendant(
      of: find.byType(YakoThemeSwitch),
      matching: find.byWidgetPredicate(
        (Widget w) => w is SizedBox && w.width == 18 && w.height == 18,
      ),
    )
    .first;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
  });
}

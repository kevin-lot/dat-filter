// This is a Flutter widget test for the DatFilter application.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/src/presentation/molecule/input_files_picker.dart';
import 'package:app/src/presentation/molecule/output_path_picker.dart';
import 'package:app/src/presentation/molecule/tabs_panel.dart';
import 'package:app/src/presentation/organism/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App initializes with correct structure', (final WidgetTester tester) async {
    // Build our app with Riverpod
    await tester.pumpWidget(
      const MaterialApp(
        home: Layout(),
      ),
    );

    // Wait for the app to initialize
    await tester.pumpAndSettle();

    // Verify that the Layout widget is present
    expect(find.byType(Layout), findsOneWidget);

    // Verify that key UI components are present
    expect(find.byType(PickOutputPath), findsOneWidget);
    expect(find.byType(InputFilesPicker), findsOneWidget);
    expect(find.byType(TabsPanel), findsOneWidget);

    // Verify that the Go button is present but disabled (since no files are selected)
    final Finder goButtonFinder = find.byType(ElevatedButton);
    expect(goButtonFinder, findsOneWidget);

    final ElevatedButton goButton = tester.widget(goButtonFinder);
    expect(goButton.onPressed, isNull); // Button should be disabled initially
  });
}

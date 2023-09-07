import 'package:flutter/material.dart';
import 'package:flutter_fic7_app/file_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('file widget displays the currect file name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: FileWidget(fileName: 'educative.txt'),
    ));

    // Verify that our widget displays the correct file name.
    expect(find.text('File: educative.txt'), findsOneWidget);
  });
}
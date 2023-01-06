// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders test', (WidgetTester tester) async {
    // Create the TextField widget
    final TextField textField = TextField();
    final Visibility submitButton = Visibility(child: Container());

    // Build the widget tree
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(child: textField,),
            Expanded(child: submitButton),
          ],
        )
      ),
    ));

    // Verify that the TextField is displayed
    expect(find.byWidget(textField), findsOneWidget);
    expect(find.byWidget(submitButton), findsOneWidget);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:paytym/main.dart';
import 'package:paytym/screens/login/login_controller.dart';

void main() {
  // testWidgets('Login controller smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  group('LoginController', () {
    test('value should start with null', () {
      expect(LoginController().loginResponseModel, null);
    });

    test('email validator should return null', () {
      final loginController = LoginController();

      var value = loginController.emailValidator('akhil@gmail.com');

      expect(value, null);
    });

    test('email validator should return enter valid email message', () {
      final loginController = LoginController();

      var value = loginController.emailValidator('akhil@gmail');

      expect(value, 'Enter a valid email');
    });
  });
}

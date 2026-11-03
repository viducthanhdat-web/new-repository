// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:projects2/main.dart';
import 'package:projects2/splash_screen.dart';

void main() {
  testWidgets('App smoke test loads SplashScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that SplashScreen is displayed.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance time past splash delay so no timers are left pending
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}

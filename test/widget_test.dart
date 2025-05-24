import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_album/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AppAlbum());

    // Add your actual UI test logic here. The default "counter" test likely doesn't apply anymore.
    // So, for now, just check if the app renders something basic.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

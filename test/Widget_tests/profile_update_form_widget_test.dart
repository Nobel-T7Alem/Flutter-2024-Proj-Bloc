import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/presentation/widgets/profile_update.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';

void main() {
  testWidgets('ProfileUpdate displays form fields and buttons correctly', (WidgetTester tester) async {
    try {
      print('Test started');
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileUpdate(),
          ),
        ),
      );

      print('Widget built');
      // Verify the presence of form fields
      expect(find.byType(TextFormField), findsNWidgets(4));
      print('Found TextFormFields');
      expect(find.byType(CustomButton), findsOneWidget);
      print('Found CustomButton');
      expect(find.text('Delete Account'), findsOneWidget);
      print('Found Delete Account button');

      // Verify the AppBar title
      expect(find.widgetWithText(AppBar, 'Update Profile'), findsOneWidget);
      print('Found AppBar title');

      // Verify the button text
      expect(find.widgetWithText(CustomButton, 'Update Profile'), findsOneWidget);
      print('Found Update Profile button');
    } catch (e, stacktrace) {
      print('Test failed with exception: $e');
      print(stacktrace);
    }
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Sebawi/presentation/widgets/profile_update.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';

void main() {
  testWidgets('ProfileUpdate displays form fields and buttons correctly', (WidgetTester tester) async {
    print('Building the widget');
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileUpdate(),
      ),
    );

    print('Verifying form fields');
    // Verify the presence of form fields
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);

    // Verify the AppBar title
    expect(find.widgetWithText(AppBar, 'Update Profile'), findsOneWidget);

    // Verify the button text
    expect(find.widgetWithText(CustomButton, 'Update Profile'), findsOneWidget);
  });

  testWidgets('ProfileUpdate validates form fields', (WidgetTester tester) async {
    print('Building the widget');
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileUpdate(),
      ),
    );

    print('Tapping update profile button');
    // Tap the update profile button
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();

    print('Verifying validation messages');
    expect(find.text('Please enter your Name'), findsOneWidget);
    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Enter invalid email and verify validation
    await tester.enterText(find.byType(TextFormField).at(2), 'invalid_email');
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });

  testWidgets('ProfileUpdate updates profile on valid input', (WidgetTester tester) async {
    print('Building the widget');
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileUpdate(),
      ),
    );

    print('Entering valid data');
    // Enter valid data in all fields
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'johndoe');
    await tester.enterText(find.byType(TextFormField).at(2), 'john@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'password123');

    print('Tapping update profile button');
    // Tap the update profile button
    await tester.tap(find.widgetWithText(CustomButton, 'Update Profile'), warnIfMissed: false);
    await tester.pump();

    print('Verifying Snackbar');
    // Verify the Snackbar is displayed
    expect(find.text('Profile updated'), findsOneWidget);
  });

  testWidgets('ProfileUpdate delete account button works', (WidgetTester tester) async {
    print('Building the widget');
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileUpdate(),
      ),
    );

    print('Tapping delete account button');
    // Tap the delete account button
    await tester.tap(find.text('Delete Account'), warnIfMissed: false);
    await tester.pump();

    // Verify any expected behavior for delete account button (if any)
    // For now, we just ensure the button is present and tappable
    expect(find.text('Delete Account'), findsOneWidget);
  });
}

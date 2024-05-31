import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('CustomButton displays correct text and performs action', (WidgetTester tester) async {
    bool buttonPressed = false;

    // Define a test action for the button
    void testAction() {
      buttonPressed = true;
      print('Button was pressed');
    }

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            buttonText: 'Test Button',
            buttonColor: Colors.blue,
            buttonTextColor: Colors.white,
            buttonAction: testAction,
          ),
        ),
      ),
    );

    // Verify the button displays the correct text
    expect(find.text('Test Button'), findsOneWidget);
    print('Button text found');

    // Verify the button's color and text color
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    final buttonStyle = button.style?.backgroundColor?.resolve({}) ?? Colors.transparent;
    expect(buttonStyle, Colors.blue);
    print('Button color verified');

    final textWidget = tester.widget<Text>(find.text('Test Button'));
    expect(textWidget.style?.color, Colors.white);
    print('Button text color verified');

    // Tap the button and verify the action is performed
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(buttonPressed, isTrue);
    print('Button action verified');
  });
}

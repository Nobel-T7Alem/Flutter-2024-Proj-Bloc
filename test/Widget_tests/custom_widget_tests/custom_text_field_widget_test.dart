import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomTextFormField displays correct label text and handles input', (WidgetTester tester) async {
    print('Test started');
    String inputText = '';
    String? Function(String?)? validator = (value) => value == null || value.isEmpty ? 'Cannot be empty' : null;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            labelText: 'Test Label',
            obscureText: true,
            onChange: (value) {
              inputText = value ?? '';
              print('onChange called with value: $inputText');
            },
            validator: validator,
          ),
        ),
      ),
    );

    print('Widget built');
    
    // Verify the label text is displayed correctly
    expect(find.text('Test Label'), findsOneWidget);
    print('Label text found');

    // Enter text and verify the onChange callback
    await tester.enterText(find.byType(TextFormField), 'Test Input');
    await tester.pump();
    expect(inputText, 'Test Input');
    print('onChange callback verified with input: $inputText');

    // Verify the validator
    final textField = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(textField.validator?.call(''), 'Cannot be empty');
    expect(textField.validator?.call('Valid input'), isNull);
    print('Validator verified');

    // Verify the obscureText property by accessing the underlying TextField widget
    final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
    expect(textFieldWidget.obscureText, isTrue);
    print('obscureText property verified');
  });
}

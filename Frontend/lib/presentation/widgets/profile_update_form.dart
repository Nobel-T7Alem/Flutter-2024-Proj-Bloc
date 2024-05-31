import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProfileUpdateForm extends StatefulWidget {
  const ProfileUpdateForm({super.key});

  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 78, 33),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
            onSaved: (value) => _username = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Username'),
            obscureText: true,
            onSaved: (value) => _password = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => _email = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            onSaved: (value) => _name = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
              buttonText: 'Update Profile',
              buttonColor: Colors.green,
              buttonTextColor: Colors.white,
              buttonAction: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Save form data to server or database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated')),
                  );
                }
              }),
          const SizedBox(height: 200),
          TextButton(
            onPressed: () {
              // Add delete account logic
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Text color
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}

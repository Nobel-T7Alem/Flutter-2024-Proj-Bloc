import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChange;
  final TextEditingController? controller;


  const CustomTextFormField({super.key,
    required this.labelText,
    this.obscureText = false,
    this.inputFormatters,
    this.onChange,
    this.validator,
    this.controller,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 4.0),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 31, 78, 33),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(213, 213, 213, 1),
            ),
          ),
          labelText: labelText,
          errorText: validator != null ? validator!(null) : null,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 165, 165, 165),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        onChanged: onChange,
        validator: validator,
        controller: controller,
      ),
    );
  }
}
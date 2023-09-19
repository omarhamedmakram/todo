import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType textInputType;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          decoration: InputDecoration(
              // helperText:c "Name",
              labelText: labelText,
              labelStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)))),
    );
  }
}

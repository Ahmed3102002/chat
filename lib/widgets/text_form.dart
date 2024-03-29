import 'package:chater/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.labelText = '',
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.validator, this.prefixIcon,  this.color=kPrimaryColor,
  });

  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      style: GoogleFonts.abhayaLibre(
        fontSize: 15,
        color: color,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintMaxLines: 1,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 10),
        hintStyle: GoogleFonts.abhayaLibre(
          fontSize: 18,
          color: color,
        ),
        border: const OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}

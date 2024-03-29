import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/const.dart';

class StyleOfText extends StatelessWidget {
  const StyleOfText({
    super.key,
    required this.text,
    this.color = kPrimaryColor,
    this.fontSize = 15,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.actor(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ));
  }
}

import 'package:chater/helper/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/const.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = const Icon(
      Icons.login,
      color: kPrimaryColor,
    ),
  });

  final void Function()? onPressed;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: kSenderColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      onPressed: onPressed,
      label: StyleOfText(
        text: title,
        fontSize: 25,
        color: kPrimaryColor,
      ),
    );
  }
}

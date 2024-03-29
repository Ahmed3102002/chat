import 'package:chater/helper/text_style.dart';
import 'package:chater/utils/const.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      elevation: 5,
      padding: const EdgeInsets.all(8),
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      content: StyleOfText(
        text: message,
        color: kSenderColor,
      ),
    ),
  );
}

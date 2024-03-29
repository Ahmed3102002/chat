import 'package:chater/helper/text_style.dart';
import 'package:flutter/material.dart';

class QuestionButton extends StatelessWidget {
  const QuestionButton({
    super.key,
    required this.question,
    required this.page,
  });
  final String question;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyleOfText(text: question),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, page);
          },
          child: StyleOfText(
            text: page,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

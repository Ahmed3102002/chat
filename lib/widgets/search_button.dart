import 'package:chater/utils/const.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: kSenderColor,
        borderRadius: borderRadius,
        elevation: 5,
        child: IconButton(
          iconSize: 25,
          onPressed: onPressed,
          icon: const Icon(
            Icons.search_outlined,
            color: kSenderColor,
          ),
        ),
      ),
    );
  }
}

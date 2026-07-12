import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String normalText;
  final String boldText;

  const BoldText({super.key, required this.normalText, required this.boldText});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: normalText),
        ],
      ),
    );
  }
}

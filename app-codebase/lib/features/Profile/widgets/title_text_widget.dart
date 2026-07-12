import 'package:flutter/material.dart';

enum PageTitleType { large, medium, small, section }

class TitleTextWidget extends StatelessWidget {
  final String titleText;
  final PageTitleType type;

  const TitleTextWidget({
    super.key,
    required this.titleText,
    required this.type,
  });

  TextStyle _getTextStyle() {
    switch (type) {
      case PageTitleType.large:
        return const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

      case PageTitleType.medium:
        return const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        );

      case PageTitleType.small:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        );

      case PageTitleType.section:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(titleText, style: _getTextStyle());
  }
}

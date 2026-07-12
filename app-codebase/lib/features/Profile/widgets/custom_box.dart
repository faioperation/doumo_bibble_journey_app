import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomText extends StatelessWidget {
  final String textIconPath;
  final String text;
  final IconData trailingIcon;
  final String? subText;
  final VoidCallback? onTap;

  const CustomText({
    super.key,
    required this.textIconPath,
    required this.text,
    required this.trailingIcon,
    this.subText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        textIconPath,
                        color: Color(0xff83BF8B),
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    trailingIcon,
                    color: const Color(0xff83BF8B),
                    size: 20,
                  ),
                ],
              ),
            ),


            if (subText != null)
              Padding(
                padding: const EdgeInsets.only(left: 44, bottom: 8),
                child: Text(
                  subText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

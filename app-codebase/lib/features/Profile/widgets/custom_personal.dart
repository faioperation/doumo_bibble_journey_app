import 'package:flutter/material.dart';

class CustomPersonal extends StatelessWidget {
  final IconData textIcon;
  final String text;
  final String subText;

  const CustomPersonal({
    super.key,
    required this.textIcon,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                textIcon,
                color: const Color(0xff83BF8B),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),

                Text(
                  subText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff787878),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

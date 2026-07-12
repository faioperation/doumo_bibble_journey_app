import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNotification extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String timeAgo;
  final bool isRead;

  const CustomNotification({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.timeAgo,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: SvgPicture.asset(image, width: 36, height: 36),
            ),
            if (!isRead)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 13,
                      color: isRead ? Colors.grey : const Color(0xff787878))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 19),
          child: Text(timeAgo,
              style: TextStyle(
                  fontSize: 14,
                  color: isRead ? Colors.grey : const Color(0xff787878))),
        ),
      ],
    );
  }
}


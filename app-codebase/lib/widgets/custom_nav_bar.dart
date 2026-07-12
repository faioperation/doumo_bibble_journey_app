import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavbar extends StatelessWidget {
  final Function(int) onItemPressed;
  final int currentIndex;

  const CustomNavbar({
    super.key,
    required this.onItemPressed,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF8F5F2),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xff83BF8B),
      unselectedItemColor: const Color(0xff595959),
      onTap: onItemPressed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Vector.svg',
            width: 24,
            height: 24,
            color: currentIndex == 0
                ? const Color(0xff83BF8B)
                : const Color(0xff595959),
          ),
          label: "home".tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Vector (1).svg',
            width: 24,
            height: 24,
            color: currentIndex == 1
                ? const Color(0xff83BF8B)
                : const Color(0xff595959),
          ),
          label: "bible".tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/Vector (2).svg',
            width: 24,
            height: 24,
            color: currentIndex == 2
                ? const Color(0xff83BF8B)
                : const Color(0xff595959),
          ),
          label: "journey".tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/User.svg',
            width: 24,
            height: 24,
            color: currentIndex == 3
                ? const Color(0xff83BF8B)
                : const Color(0xff595959),
          ),
          label: "profile".tr(),
        ),
      ],
    );
  }
}

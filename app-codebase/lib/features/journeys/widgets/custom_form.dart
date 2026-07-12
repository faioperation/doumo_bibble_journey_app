import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomForm({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocked = onTap == null;

    return Opacity(
      opacity: isLocked ? 0.5 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          margin: const EdgeInsets.symmetric(vertical: 6),
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffE5EDE8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12),
              ],

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (trailing != null)
                trailing!
              else
                Icon(
                  isLocked ? Icons.lock : Icons.arrow_forward_ios,
                  size: 16,
                  color: isLocked ? Colors.grey : Colors.black54,
                ),
            ],
          ),
        ),
      ),
    );
  }
}



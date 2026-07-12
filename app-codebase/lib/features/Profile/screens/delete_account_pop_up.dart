import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showDeletePopup(BuildContext context, {required VoidCallback onConfirm}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE7EEE8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Confirm Delete",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Are you sure you want to permanently delete your account? This action cannot be undone.",
                style: const TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel".tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8BC38A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 25),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

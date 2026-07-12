import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<Map<String, List<NotificationModel>>> _future;

  @override
  void initState() {
    super.initState();
    _future = NotificationService.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "notification".tr(),
        onTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<Map<String, List<NotificationModel>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _errorWidget();
          }

          final today = snapshot.data!['today'] ?? [];
          final yesterday = snapshot.data!['yesterday'] ?? [];
          final earlier = snapshot.data!['earlier'] ?? [];

          if (today.isEmpty && yesterday.isEmpty && earlier.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView(
            children: [
              if (today.isNotEmpty)
                _sectionTitleWithClear("today".tr(), onClear: _clearAll),
              ...today.map(_buildNotification).toList(),

              if (yesterday.isNotEmpty)
                _sectionTitle("yesterday".tr()),
              ...yesterday.map(_buildNotification).toList(),

              if (earlier.isNotEmpty)
                _sectionTitle("earlier".tr()),
              ...earlier.map(_buildNotification).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitleWithClear(
      String title, {
        required VoidCallback onClear,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, color: Colors.black87),
          ),
          TextButton(
            onPressed: onClear,
            child: Text(
              "clear_all".tr(),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff83BF8B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, color: Colors.black87),
      ),
    );
  }

  Widget _buildNotification(NotificationModel n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          if (!n.isRead) {
            try {
              await NotificationService.markAsRead(n.id);
              setState(() => n.isRead = true);
            } catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to mark as read"),
                ),
              );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: n.isRead ? Colors.white : const Color(0xffEEF6EF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                n.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                n.message,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                _formatDateTime(n.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _clearAll() async {
    try {
      await NotificationService.clearAll();
      setState(() {
        _future = NotificationService.fetchNotifications();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All notifications marked as read"),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to clear notifications"),
        ),
      );
    }
  }

  String _formatDateTime(DateTime date) {
    final d = date.toLocal();

    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final ampm = d.hour >= 12 ? "PM" : "AM";

    return "${d.day.toString().padLeft(2, '0')} "
        "${_month(d.month)} "
        "${d.year} • $hour:$minute $ampm";
  }

  String _month(int m) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[m - 1];
  }

  Widget _errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          const Text(
            "Failed to load notifications",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _future = NotificationService.fetchNotifications();
              });
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

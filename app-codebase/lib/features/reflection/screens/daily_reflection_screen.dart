import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import 'package:bible_journey/features/journeys/screens/journey_detail_screen.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:bible_journey/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth_utils.dart';

class DailyReflectionScreen extends StatefulWidget {
  final int journeyId;
  final int dayId;

  const DailyReflectionScreen({
    super.key,
    required this.journeyId,
    required this.dayId,
  });

  @override
  State<DailyReflectionScreen> createState() => _DailyReflectionScreenState();
}

class _DailyReflectionScreenState extends State<DailyReflectionScreen> {
  bool _isLoading = false;
  String? _dayStatus;
  final TextEditingController _reflectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDayStatus();
  }

  Future<void> _fetchDayStatus() async {
    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) return;

    try {
      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/progress/journey/${widget.journeyId}"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final days = data['days'] as List<dynamic>;

        final day = days.firstWhere(
              (d) => d['day_id'] == widget.dayId,
          orElse: () => null,
        );

        setState(() {
          _dayStatus = day?['status'];
        });
      }
    } catch (_) {
      setState(() {
        _dayStatus = null;
      });
    }
  }

  Future<void> completeDay() async {
    if (_dayStatus == "completed") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => JourneyDetailScreen(
            journeyId: widget.journeyId,
          ),
        ),
      );
      return;
    }

    if (_dayStatus != "current") return;

    if (_reflectionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Write Your Reflection")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/progress/complete-day/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "journey_id": widget.journeyId,
          "day_id": widget.dayId,
          "action": "complete",
          "reflecton_note": _reflectionController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403) {
        await AuthUtils.handleUnauthorized();
        throw Exception("Unauthorized! Logging out...");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Day completed")),
        );

        setState(() {
          _dayStatus = "completed";
          _isLoading = false;
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => JourneyDetailScreen(
                journeyId: widget.journeyId,
              ),
            ),
          );
        });
      }

      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data["error"] ??
                  "One day at a time! Come back tomorrow.",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dayStatus == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bool isCompleted = _dayStatus == "completed";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: CustomAppBar(
        title: "daily_reflection".tr(),
        onTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "write_daily_reflection".tr(),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 465,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffE3E9E3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _reflectionController,
                      maxLines: null,
                      expands: true,
                      enabled: !isCompleted, // 🔒 disable after completion
                      decoration: InputDecoration(
                        hintText: "write_here".tr(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                CustomButton(
                  text: _isLoading
                      ? "Processing..."
                      : isCompleted
                      ? "Completed"
                      : "mark_as_done".tr(),
                  onTap: isCompleted ? null : completeDay,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

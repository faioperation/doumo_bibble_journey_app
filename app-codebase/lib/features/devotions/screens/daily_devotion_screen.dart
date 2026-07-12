import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import '../../../app/Urls.dart';
import '../../../app/constants.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../models/devotion_model.dart';
import '../services/daily_devotion_api.dart';
import 'daily_devotion_quiz_screen.dart';

class DailyDevotionScreen extends StatefulWidget {
  final int journeyId;
  final int dayId;

  const DailyDevotionScreen({
    super.key,
    required this.journeyId,
    required this.dayId,
  });

  @override
  State<DailyDevotionScreen> createState() => _DailyDevotionScreenState();
}

class _DailyDevotionScreenState extends State<DailyDevotionScreen> {
  int _selectedContainer = -1;
  late Future<DevotionResponse> devotionFuture;

  @override
  void initState() {
    super.initState();
    devotionFuture = DevotionApi.getTodayDevotion(widget.journeyId, widget.dayId);
  }

  Future<void> completeDevotionStep(bool isCompleted) async {
    if (isCompleted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyDevotionQuizScreen(journeyId: widget.journeyId, dayId: widget.dayId),
        ),
      );
      return;
    }

    try {
      final token = await LocalStorage.getToken();
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/progress/stepcopmplete/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "day_id": widget.dayId,
          "item_type": "devotion",
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyDevotionQuizScreen(journeyId: widget.journeyId, dayId: widget.dayId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Failed to complete step")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "devotion.title".tr(),
        onTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<DevotionResponse>(
        future: devotionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("Devotion API Error: ${snapshot.error}");
            return Center(child: Text("Something went wrong"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No devotion data found"));
          }

          final devotion = snapshot.data!.data;
          final bool isCompleted = snapshot.data!.isCompleted;


          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    devotion.scriptureName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSelectableContainer(
                    index: 0,
                    title: "Scripture",
                    content: devotion.devotion,
                    centerText: true,
                  ),
                  const SizedBox(height: 8),
                  _buildSelectableContainer(
                    index: 1,
                    title: "Reflection",
                    content: devotion.reflection,
                  ),
                  const SizedBox(height: 30),

                  // CustomButton(
                  //   text: "devotion.completed".tr(),
                  //   onTap: () => completeDevotionStep(snapshot.data!.isCompleted),
                  // ),
                  CustomButton(
                    text: isCompleted
                        ? "Completed"
                        : "Next".tr(),
                    onTap: isCompleted
                        ? null
                        : () => completeDevotionStep(false),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectableContainer({
    required int index,
    required String title,
    required String content,
    bool centerText = false,
  }) {
    bool isSelected = _selectedContainer == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedContainer = isSelected ? -1 : index;
        });
      },
      child: Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffE3E9E3) : const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 14),
                  textAlign: centerText ? TextAlign.center : TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


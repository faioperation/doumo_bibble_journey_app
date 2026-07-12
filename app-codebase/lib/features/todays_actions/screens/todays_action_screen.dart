import 'dart:convert';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/app/Urls.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../../reflection/screens/daily_reflection_screen.dart';
import '../services/today_action_api.dart';

class TodayActionScreen extends StatefulWidget {
  final int dayId;
  final int journeyId;

  const TodayActionScreen({
    super.key,
    required this.dayId,
    required this.journeyId,
  });

  @override
  State<TodayActionScreen> createState() => _TodayActionScreenState();
}

class _TodayActionScreenState extends State<TodayActionScreen> {
  late Future<Map<String, dynamic>> actionFuture;
  bool isCompleting = false;

  @override
  void initState() {
    super.initState();
    actionFuture = ActionApi.getDayAction(
      journeyId: widget.journeyId,
      dayId: widget.dayId,
    );
  }

  Future<void> markAsDone(bool isCompleted) async {
    if (isCompleted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DailyReflectionScreen(
            journeyId: widget.journeyId,
            dayId: widget.dayId,
          ),
        ),
      );
      return;
    }

    setState(() => isCompleting = true);

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
          "item_type": "action",
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
            builder: (_) => DailyReflectionScreen(
              journeyId: widget.journeyId,
              dayId: widget.dayId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "You Must Complete Prayer & Devotion First"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error")),
      );
    } finally {
      setState(() => isCompleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Today's Action", onTap: (){
        Navigator.pop(context);
      }),
      body: FutureBuilder<Map<String, dynamic>>(
        future: actionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("ACTION API ERROR: ${snapshot.error}");
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }


          final action = snapshot.data!['data'];
          final bool isCompleted = snapshot.data!['is_completed'];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xffE3E9E3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    action['action'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff616161),
                    ),
                  ),
                ),
                const Spacer(),
                // CustomButton(
                //   text: isCompleting ? "Processing..." : "mark_as_done".tr(),
                //   onTap: () => markAsDone(snapshot.data!['is_completed']),
                // ),

          CustomButton(
          text: isCompleted ? "Completed" : "Next".tr(),
          onTap: isCompleted ? null : () => markAsDone(false),
          ),

          ],
            ),
          );
        },
      ),
    );
  }
}




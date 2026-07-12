import 'package:bible_journey/features/reflection/screens/daily_reflection_screen.dart';
import 'package:bible_journey/features/todays_actions/screens/todays_action_screen.dart';
import 'package:flutter/material.dart';
import '../../../main_bottom_nav_screen.dart';
import '../../../widgets/custom_nav_bar.dart';
import '../../Profile/screens/profile_screen.dart';
import '../../bible/screens/bible_screen.dart';
import '../../devotions/screens/daily_devotion_screen.dart';
import '../../prayer/screens/prayer_screen.dart';
import '../models/journey_day_content_model.dart';
import '../services/journey_day_content_api.dart';
import '../widgets/custom_form.dart';
import 'journey_screen.dart';

class JourneyDetails1 extends StatefulWidget {
  final int journeyId;
  final int dayId;

  const JourneyDetails1({
    super.key,
    required this.journeyId,
    required this.dayId,
  });

  @override
  State<JourneyDetails1> createState() => _JourneyDetails1State();
}

class _JourneyDetails1State extends State<JourneyDetails1> {
  late Future<JourneyDayContentResponse> contentFuture;

  @override
  void initState() {
    super.initState();
    contentFuture = JourneyDayContentApi.getDayContent(
      widget.journeyId,
      widget.dayId,
    );
  }

  IconData getIcon(String step) {
    switch (step) {
      case "prayer":
        return Icons.self_improvement;
      case "devotion":
        return Icons.menu_book;
      case "action":
        return Icons.flash_on;
      case "reflection":
        return Icons.edit_note;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        title: const Text("Day Progress"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffF8F5F2),
      ),
      body: FutureBuilder<JourneyDayContentResponse>(
        future: contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.dayTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ...data.steps.map((step) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomForm(
                      title: step.stepName.toUpperCase(),
                      leading: Icon(
                        getIcon(step.stepName),
                        color: step.isCompleted
                            ? Colors.green
                            : Colors.orange,
                      ),
                      trailing: step.isCompleted
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        switch (step.stepName) {
                          case "prayer":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PrayerScreen(
                                  journeyId: widget.journeyId,
                                  dayId: widget.dayId,
                                ),
                              ),
                            );
                            break;
                          case "devotion":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyDevotionScreen(
                                  journeyId: widget.journeyId,
                                  dayId: widget.dayId,
                                ),
                              ),
                            );
                            break;
                          case "action":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TodayActionScreen(dayId: widget.dayId, journeyId: widget.journeyId,),
                              ),
                            );
                            break;
                          case "reflection":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyReflectionScreen(journeyId: widget.journeyId, dayId: widget.dayId,),
                              ),
                            );
                            break;
                        }
                      },

                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}



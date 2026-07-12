import 'package:bible_journey/features/journeys/screens/journey_screen.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/daily_journey_details_model.dart';
import '../services/daily_journey_details_api.dart';
import '../widgets/custom_form.dart';
import 'daily_journey_details1_screen.dart';

class JourneyDetailScreen extends StatefulWidget {
  final int journeyId;

  const JourneyDetailScreen({super.key, required this.journeyId});

  @override
  State<JourneyDetailScreen> createState() => _JourneyDetailScreenState();
}

class _JourneyDetailScreenState extends State<JourneyDetailScreen> {
  late Future<DailyJourneyResponse> dailyJourneyFuture;

  @override
  void initState() {
    super.initState();
    dailyJourneyFuture = DailyJourneyApi.getDailyJourney(widget.journeyId);
  }

  bool canAccess(String status) {
    return status == "current" || status == "completed";
  }

  IconData getIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "current":
        return Icons.play_circle_fill;
      default:
        return Icons.lock;
    }
  }

  Color getColor(String status) {
    switch (status) {
      case "completed":
        return Colors.green;
      case "current":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: CustomAppBar(
        title: "journey_details".tr(),
        onTap: () {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => const JourneyScreen()),
          // );
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>JourneyScreen()), (route)=>false);
        },
      ),
      body: FutureBuilder<DailyJourneyResponse>(
        future: dailyJourneyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong: ${snapshot.error}"),
            );
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(data.journeyDetails.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.journey.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.journeyDetails.details,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${data.days.length}-Day Devotional series",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: data.days.map((day) {
                      final isAllowed = canAccess(day.status);

                      return Opacity(
                        opacity: isAllowed ? 1 : 0.5,
                        child: CustomForm(
                          title: "Day ${day.order}: ${day.dayName}",
                          leading: Icon(
                            getIcon(day.status),
                            color: getColor(day.status),
                          ),
                          onTap: isAllowed
                              ? () {
                                  print("Journey ID: ${data.journey.id}");
                                  print("Day ID: ${day.dayId}");

                                  if (data.journey.id == null ||
                                      day.dayId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Invalid journey/day data",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => JourneyDetails1(
                                        journeyId: data.journey.id!,
                                        dayId: day.dayId!,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

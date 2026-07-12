import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import 'package:bible_journey/features/devotions/screens/daily_devotion_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../../../widgets/buttons/custom_button.dart';
import '../widgets/audio_player_card.dart';
import '../models/prayer_model.dart';
import '../services/prayer_api.dart';

class PrayerScreen extends StatefulWidget {
  final int journeyId;
  final int dayId;

  const PrayerScreen({super.key, required this.journeyId, required this.dayId});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  late Future<PrayerResponse> prayerFuture;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    prayerFuture = PrayerApi.getTodayPrayer(widget.journeyId, widget.dayId);
  }

  void stopAudio() {
    _audioPlayer?.stop();
  }

  Future<void> completePrayerStep(bool isCompleted) async {
    stopAudio();

    if (isCompleted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyDevotionScreen(
            journeyId: widget.journeyId,
            dayId: widget.dayId,
          ),
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
          "item_type": "prayer",
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Step Completed")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyDevotionScreen(
              journeyId: widget.journeyId,
              dayId: widget.dayId,
            ),
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
  void dispose() {
    _audioPlayer?.stop();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "daily_prayer".tr(),
        onTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<PrayerResponse>(
        future: prayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No prayer data found"));
          }

          final prayer = snapshot.data!.data;
          final bool isCompleted = snapshot.data!.isCompleted;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Today's Prayer",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    prayer.prayer,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 60),
                  AudioPlayerCard(
                    url: prayer.audioUrl,
                    title: "Prayer Audio",
                    subtitle: "Read by Daily Devotions",
                    thumbnail: Container(color: Colors.redAccent.shade100),
                    playerControllerSetter: (player) {
                      _audioPlayer = player;
                    },
                    onStop: () {
                      debugPrint("Audio stopped manually");
                    },
                  ),
                  const SizedBox(height: 32),
                  // CustomButton(
                  //   text: "Next",
                  //   onTap: () {
                  //     completePrayerStep(snapshot.data!.isCompleted);
                  //   },
                  // ),
                  CustomButton(
                    text: isCompleted
                        ? "Completed"
                        : "Next".tr(),
                    onTap: isCompleted
                        ? null
                        : () => completePrayerStep(isCompleted),
                  ),
                  // CustomButton(
                  //   text: isCompleted
                  //       ? "Completed"
                  //       : "devotion.completed".tr(),
                  //   onTap: () {
                  //     completePrayerStep(isCompleted);
                  //   },
                  // ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

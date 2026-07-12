import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/home/widgets/home_box.dart';
import 'package:bible_journey/features/journeys/screens/journey_detail_screen.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import '../models/journey_model.dart';
import '../services/journey_api.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  late Future<List<Journey>> journeyFuture;

  @override
  void initState() {
    super.initState();
    journeyFuture = JourneyApi.getJourneys();
    debugPrint("OPENED: PrayerScreen");
  }

  int mapIndex(int uiIndex) {
    final row = uiIndex ~/ 2;
    final isOddRow = row % 2 == 1;
    return !isOddRow ? uiIndex : row * 2 + (1 - uiIndex % 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(

        title: "life_area_journey".tr(),
        // onTap: () {
        //   Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (_) => MainBottomNavScreen()),
        //         (_) => false,
        //   );
        // },
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<Journey>>(
            future: journeyFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final journeys = snapshot.data!;
              final total = journeys.length;

              return GridView.builder(
                itemCount: total,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 32,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, uiIndex) {
                  final dataIndex = mapIndex(uiIndex);
                  final journey = journeys[dataIndex];

                  final row = uiIndex ~/ 2;
                  final col = uiIndex % 2;
                  final hasNext = dataIndex < total - 1;

                  Widget iconWidget = Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      journey.journeyIcon.isNotEmpty
                          ? Image.network(
                        journey.journeyIcon,
                        width: 40,
                        height: 40,
                      )
                          : const Icon(Icons.explore, size: 40),

                      const Spacer(),

                      if (journey.status == "locked")
                        const Icon(
                          Icons.lock,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                    ],
                  );


                  Widget arrowWidget = const SizedBox.shrink();

                  if (hasNext) {
                    if (row % 2 == 0 && col == 0) {
                      arrowWidget = const Positioned(
                        right: -20,
                        top: 0,
                        bottom: 0,
                        child: Icon(Icons.arrow_forward, size: 26),
                      );
                    }

                    if (row % 2 == 0 && col == 1) {
                      arrowWidget = const Positioned(
                        bottom: -28,
                        left: 0,
                        right: 0,
                        child: Icon(Icons.arrow_downward, size: 26),
                      );
                    }

                    if (row % 2 == 1 && col == 1) {
                      arrowWidget = const Positioned(
                        left: -20,
                        top: 0,
                        bottom: 0,
                        child: Icon(Icons.arrow_back, size: 26),
                      );
                    }

                    if (row % 2 == 1 && col == 0) {
                      arrowWidget = const Positioned(
                        bottom: -28,
                        left: 0,
                        right: 0,
                        child: Icon(Icons.arrow_downward, size: 26),
                      );
                    }
                  }

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: HomeBox(
                          icon: iconWidget,
                          title: journey.name,
                          subtitle: "Completed days: ${journey.completedDays}",
                          onTap: () {
                            if (journey.status == "locked") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Complete previous journey to unlock this",
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      JourneyDetailScreen(journeyId: journey.id),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      arrowWidget,
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

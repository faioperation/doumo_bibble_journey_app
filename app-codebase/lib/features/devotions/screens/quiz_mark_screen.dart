import 'package:bible_journey/features/devotions/screens/daily_devotion_quiz_screen.dart';
import 'package:bible_journey/features/todays_actions/screens/todays_action_screen.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:bible_journey/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

class QuizMarkScreen extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int journeyId;
  final int dayId;

  const QuizMarkScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.journeyId,
    required this.dayId,
  });

  @override
  State<QuizMarkScreen> createState() => _QuizMarkScreenState();
}

class _QuizMarkScreenState extends State<QuizMarkScreen> {

  String getFeedbackMessage() {
    if (widget.totalQuestions == 0) return "No questions attempted";

    double percent = widget.correctAnswers / widget.totalQuestions * 100;

    if (percent < 30) {
      return "Keep Trying! You can do better.";
    } else if (percent >= 30 && percent < 60) {
      return "Good Effort! Keep Improving.";
    } else if (percent >= 60 && percent < 100) {
      return "Great Job! Almost Perfect.";
    } else {
      return "Excellent! Perfect Score!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double progressFactor = widget.totalQuestions > 0
        ? widget.correctAnswers / widget.totalQuestions
        : 0;

    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: CustomAppBar(
        title: "Quiz Complete",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),

              Text(
                getFeedbackMessage(),
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),

              Container(
                height: screenHeight * 0.015,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff83BF8B),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: const Color(0xff83BF8B)),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffE3E9E3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/check_circle.png',
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.18,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Correct',
                        style: TextStyle(
                          color: const Color(0xff83BF8B),
                          fontSize: screenHeight * 0.06,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '${widget.correctAnswers}/${widget.totalQuestions}',
                        style: TextStyle(
                          color: const Color(0xff83BF8B),
                          fontSize: screenHeight * 0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              CustomButton(
                text: "Continue",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodayActionScreen(
                        dayId: widget.dayId,
                        journeyId: widget.journeyId,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              CustomButton(
                text: "Retry",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyDevotionQuizScreen(
                        journeyId: widget.journeyId,
                        dayId: widget.dayId,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

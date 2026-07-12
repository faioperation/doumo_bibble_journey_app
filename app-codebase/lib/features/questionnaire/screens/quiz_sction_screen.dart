import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:bible_journey/features/auth/screens/premium_screen.dart';
import 'package:bible_journey/features/questionnaire/widget/custom_quiz_app_bar.dart';
import 'package:bible_journey/main_bottom_nav_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int currentQuestionIndex = 0;

  List<Map<String, dynamic>> quizData = [
    {
      "question": "How would you describe your Bible study experience so far?",
      "options": [
        "I'm a beginner",
        "I know some parts",
        "I've studied it deeply",
        "Not sure"
      ]
    },
    {
      "question": "What motivates you to explore the Bible?",
      "options": [
        "Personal spiritual growth",
        "Finding guidance for life decisions",
        "Curiosity and learning",
        "I’m not sure yet"
      ]
    },
    {
      "question": "Describe your current relationship with God?",
      "options": [
        "Strong and growing",
        "In need of renewal",
        "Unsure",
        "Other"
      ]
    },
    {
      "question": "What personal need led you to Scripture?",
      "options": [
        "Needing spiritual renewal",
        "Searching for inner peace",
        "Longing for hope",
        "Other"
      ]
    },
    {
      "question": "Which struggles feel most present in your life right now?",
      "options": [
        "Stress or anxiety",
        "Searching for inner peace",
        "Feeling alone",
        "Screen and time-wasting habits",
        "Lack of purpose",
        "Not sure",
        "Overthinking and guilt",
      ]
    },
    {
      "question": "In hard seasons, do you tend to turn toward God or away?",
      "options": [
        "I pull closer",
        "I drift away",
        "It depends",
        "I'm not sure"
      ]
    },
    {
      "question": "When life gets heavy, where do you usually turn first?",
      "options": [
        "Prayer",
        "Family or friends",
        "Bible",
        "My phone",
        "I keep it in",
        "I'm not sure",
      ]
    },
    {
      "question": "Have you noticed anything that creates distance between you and God?",
      "options": [
        "Not hearing from Him",
        "Distraction and busyness",
        "Emotional exhaustion",
        "Feeling unworthy",
        "I’m not sure",
        "Other",
      ]
    },
    {
      "question": "What can help you stay motivated to study the Bible?",
      "options": [
        "A clear plan",
        "Encouraging truth",
        "Haven’t found it yet",
        "Other"
      ]
    },
    {
      "question": "Which type of Bible content feels most helpful for you?",
      "options": [
        "Short and simple",
        "In-depth",
        "Not sure",
      ]
    },
  ];

  List<int> selectedAnswers = List.generate(10, (index) => -1);

  void goPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() => currentQuestionIndex--);
    } else {
      Navigator.pop(context);
    }
  }

  List<Map<String, String>> buildQAPairs() {
    List<Map<String, String>> qaPairs = [];

    for (int i = 0; i < quizData.length; i++) {
      int selectedIndex = selectedAnswers[i];
      if (selectedIndex != -1) {
        qaPairs.add({
          "question": quizData[i]["question"],
          "answer": quizData[i]["options"][selectedIndex],
        });
      }
    }
    return qaPairs;
  }

  Future<void> submitQuiz() async {
    String? token = await LocalStorage.getToken();
    final url = Uri.parse(Urls.categoryQuestionUrl);

    final body = jsonEncode({
      "qa_pairs": buildQAPairs(),
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      if (response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 403) {
        await AuthUtils.handleUnauthorized();
        throw Exception("Unauthorized! Logging out...");
      }

      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (route)=>false);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void goToNext() {
    if (selectedAnswers[currentQuestionIndex] == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select one option."),
        ),
      );
      return;
    }

    if (currentQuestionIndex < quizData.length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      submitQuiz();
    }
  }

  @override
  Widget build(BuildContext context) {
    String question = quizData[currentQuestionIndex]["question"];
    List options = quizData[currentQuestionIndex]["options"];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomQuizAppBar(
        title: "bible_journey".tr(),
        onBack: goPrevious,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1} of ${quizData.length}",
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / quizData.length,
              backgroundColor: Colors.grey.shade300,
              color: AppColors.primary,
              minHeight: 6,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 30),
            Text(
              question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return optionTile(index, options[index]);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: goToNext,
                child: Text(
                  currentQuestionIndex == quizData.length - 1
                      ? "Finish"
                      : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionTile(int index, String optionText) {
    bool isActive = selectedAnswers[currentQuestionIndex] == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswers[currentQuestionIndex] = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isActive
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isActive ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/devotions/screens/quiz_mark_screen.dart';
import 'package:bible_journey/features/questionnaire/widget/custom_quiz_app_bar.dart';
import '../models/quiz_model.dart';
import '../services/daily_quiz-api.dart';

class DailyDevotionQuizScreen extends StatefulWidget {
  final int journeyId;
  final int dayId;

  const DailyDevotionQuizScreen({
    super.key,
    required this.journeyId,
    required this.dayId,
  });

  @override
  State<DailyDevotionQuizScreen> createState() =>
      _DailyDevotionQuizScreenState();
}

class _DailyDevotionQuizScreenState extends State<DailyDevotionQuizScreen> {
  late Future<List<Quiz>> quizFuture;

  List<Quiz> quizzes = [];
  List<int> selectedAnswers = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    quizFuture = _loadQuizzes();
  }

  Future<List<Quiz>> _loadQuizzes() async {
    final quizJson = await QuizApi.getDayQuiz(
      journeyId: widget.journeyId,
      dayId: widget.dayId,
    );

    final list = quizJson.map<Quiz>((e) => Quiz.fromJson(e)).toList();
    selectedAnswers = List.filled(list.length, -1);
    return list;
  }

  void goPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() => currentQuestionIndex--);
    } else {
      Navigator.pop(context);
    }
  }

  void goNext() async {
    if (selectedAnswers[currentQuestionIndex] == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an option to continue"),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    if (currentQuestionIndex < quizzes.length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      await submitQuiz();
    }
  }

  Future<void> submitQuiz() async {
    final List<Map<String, dynamic>> answers = [];

    for (int i = 0; i < quizzes.length; i++) {
      answers.add({
        "daily_quiz_id": quizzes[i].id,
        "quiz_answer_option_id":
        quizzes[i].options[selectedAnswers[i]].id,
      });
    }

    final score = await QuizApi.submitQuiz(answers);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizMarkScreen(
          correctAnswers: score,
          totalQuestions: quizzes.length,
          journeyId: widget.journeyId,
          dayId: widget.dayId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomQuizAppBar(
        title: "Bible Journey",
        onBack: goPrevious,
      ),
      body: FutureBuilder<List<Quiz>>(
        future: quizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint("QUIZ ERROR => ${snapshot.error}");
            return const Center(child: Text("Failed to load quiz"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No quiz available"));
          }

          quizzes = snapshot.data!;
          final quiz = quizzes[currentQuestionIndex];
          final bool hasSelected =
              selectedAnswers[currentQuestionIndex] != -1;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${currentQuestionIndex + 1} of ${quizzes.length}",
                  style:
                  const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 6),

                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / quizzes.length,
                  backgroundColor: Colors.grey.shade300,
                  color: AppColors.primary,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(12),
                ),

                const SizedBox(height: 30),

                Text(
                  quiz.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: quiz.options.length,
                    itemBuilder: (context, index) {
                      final bool isActive =
                          selectedAnswers[currentQuestionIndex] == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnswers[currentQuestionIndex] = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isActive
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isActive
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: isActive
                                    ? AppColors.primary
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  quiz.options[index].option,
                                  style:
                                  const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasSelected
                          ? AppColors.primary
                          : Colors.grey,
                      padding:
                      const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: goNext,
                    child: Text(
                      currentQuestionIndex == quizzes.length - 1
                          ? "Finish"
                          : "Next",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18),
                    ),
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

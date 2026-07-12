class QuizQuestion {
  final String question;
  final List<String> options;
  final List<int> correctAnswers;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswers,
  });
}

class QuizOption {
  final int id;
  final String option;

  QuizOption({required this.id, required this.option});

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'],
      option: json['option'],
    );
  }
}

class Quiz {
  final int id;
  final int journeyId;
  final int daysId;
  final String question;
  final List<QuizOption> options;

  Quiz({
    required this.id,
    required this.journeyId,
    required this.daysId,
    required this.question,
    required this.options,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List;
    List<QuizOption> optionsList =
    optionsJson.map((e) => QuizOption.fromJson(e)).toList();

    return Quiz(
      id: json['id'],
      journeyId: json['journey_id'],
      daysId: json['days_id'],
      question: json['question'],
      options: optionsList,
    );
  }
}

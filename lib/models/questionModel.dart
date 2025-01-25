class Question {
  int? questionId;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int correctAnswer;

  Question({
    required this.questionId,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });

   List<String> get answers => [answer1, answer2, answer3, answer4];

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json['questionId'],
    question: json['question'],
    answer1: json['answer1'],
    answer2: json['answer2'],
    answer3: json['answer3'],
    answer4: json['answer4'],
    correctAnswer: json['correctAnswer'],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "answer1": answer1,
    "answer2": answer2,
    "answer3": answer3,
    "answer4": answer4,
    "correctAnswer": correctAnswer,
  };
}
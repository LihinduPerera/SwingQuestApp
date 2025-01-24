class User {
  int userId;
  String name;
  String answer;

  User ({
    required this.userId,
    required this.name,
    required this.answer
  });

  factory User.fromJson(Map<String , dynamic> json) => User(
    userId: json['userId'],
    name: json['name'],
    answer: json['answer']
  );

  Map<String , dynamic> toJson() => {
    "userId" : userId,
    "name" : name,
    "answer" : answer
  };
}
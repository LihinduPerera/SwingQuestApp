class User {
  int? userId;
  String name;
  String password;
  int? correctAnswersCount; // Change this to match the API's field name

  User({
    required this.userId,
    required this.name,
    required this.password,
    required this.correctAnswersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['userId'],
    name: json['name'],
    password: json['password'],
    correctAnswersCount: json['correctAnswersCount'], // Updated field name
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "password": password,
    "correctAnswersCount": correctAnswersCount, // Updated field name
  };
}
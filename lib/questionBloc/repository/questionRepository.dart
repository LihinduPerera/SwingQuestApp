import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/models/questionModel.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestions();
}

class QuestionRepositoryImpl implements QuestionRepository {
  final ApiClient _apiClient;

  QuestionRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<Question>> getQuestions() async {
    try {
      final questions = await _apiClient.getQuestions();
      
      // Shuffle the questions to get random ones, and take the first 10
      questions.shuffle();
      return questions.take(10).toList();
    } catch (e) {
      throw Exception('Error getting questions: $e');
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart'; // Adjust import according to your file structure
import 'package:swing_quest/questionBloc/repository/questionRepository.dart';
import 'question_event.dart';
import 'question_state.dart';// Adjust import according to your file structure

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository questionRepository;

  QuestionBloc({required this.questionRepository}) : super(QuestionInitial()) {
    on<LoadQuestionsEvent>((event, emit) async {
      emit(QuestionLoading());
      try {
        final questions = await questionRepository.getQuestions();
        
        // Shuffle the questions to get random ones, and take the first 10
        questions.shuffle();
        emit(QuestionLoaded(questions: questions.take(10).toList()));
      } catch (e) {
        emit(QuestionError(message: e.toString()));
      }
    });
  }
}

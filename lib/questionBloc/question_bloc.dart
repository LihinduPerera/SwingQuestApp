import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/questionBloc/repository/questionRepository.dart';
import 'question_event.dart';
import 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository questionRepository;

  QuestionBloc({required this.questionRepository}) : super(QuestionInitial()) {
    on<LoadQuestionsEvent>((event, emit) async {
      emit(QuestionLoading());
      try {
        final questions = await questionRepository.getQuestions();
        
        questions.shuffle();
        emit(QuestionLoaded(questions: questions.take(10).toList()));
      } catch (e) {
        emit(QuestionError(message: e.toString()));
      }
    });
  }
}

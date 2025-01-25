import 'package:equatable/equatable.dart';
import 'package:swing_quest/models/questionModel.dart';

abstract class QuestionState extends Equatable {
  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final List<Question> questions;

  QuestionLoaded({required this.questions});

  @override
  List<Object> get props => [questions];
}

class QuestionError extends QuestionState {
  final String message;

  QuestionError({required this.message});

  @override
  List<Object> get props => [message];
}

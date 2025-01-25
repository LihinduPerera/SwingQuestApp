import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuestionsEvent extends QuestionEvent {}

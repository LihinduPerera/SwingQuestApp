import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/questionBloc/question_Bloc.dart';
import 'package:swing_quest/questionBloc/question_state.dart';
import 'package:swing_quest/questionBloc/question_event.dart'; // Assuming this contains LoadQuestionsEvent

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int? selectedAnswer;  // Variable to store the selected answer
  int questionIndex = 0; // Track which question is displayed

  @override
  void initState() {
    super.initState();
    // Load the questions when the widget initializes
    context.read<QuestionBloc>().add(LoadQuestionsEvent());
  }

  // To move to the next question
  void _nextQuestion() {
    setState(() {
      questionIndex++;
      selectedAnswer = null;  // Reset selected answer for the next question
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swing Quest"),
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, questionState) {
          if (questionState is QuestionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (questionState is QuestionLoaded) {
            final questions = questionState.questions;

            if (questionIndex < questions.length) {
              final question = questions[questionIndex];

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      question.question,  // Display the question
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...List.generate(4, (i) {
                    return ListTile(
                      title: Text(question.answers[i]),  // Display the possible answers
                      onTap: () {
                        setState(() {
                          selectedAnswer = i + 1;  // Save answer index (1, 2, 3, or 4)
                        });
                      },
                      tileColor: selectedAnswer == i + 1 ? Colors.blue : null,  // Highlight selected answer
                    );
                  }),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text("Next Question"),
                  ),
                ],
              );
            } else {
              return Center(child: Text("No more questions available."));
            }
          } else if (questionState is QuestionError) {
            return Center(child: Text('Error: ${questionState.message}'));
          }
          return Center(child: Text('Press to Load Questions'));
        },
      ),
    );
  }
}

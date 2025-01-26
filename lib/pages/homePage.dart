import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/models/userModel.dart';
import 'package:swing_quest/questionBloc/question_Bloc.dart';
import 'package:swing_quest/questionBloc/question_state.dart';
import 'package:swing_quest/questionBloc/question_event.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int? selectedAnswer;
  int questionIndex = 0;
  int correctAnswers = 0;
  late ValueNotifier<bool> _hostingStatusNotifier;
  Timer? _hostingStatusTimer;
  late User currentUser;

  @override
  void initState() {
    super.initState();
    _hostingStatusNotifier = ValueNotifier(false); // Initialize to false initially
    context.read<QuestionBloc>().add(LoadQuestionsEvent());
    _getCurrentUser();
    _startAutomaticRefresh();
  }

  Future<void> _getCurrentUser() async {
    currentUser = User(userId: 1, name: "John Doe", password: "password", correctAnswersCount: 0);
  }

  @override
  void dispose() {
    _hostingStatusNotifier.dispose(); // Dispose of the notifier
    _hostingStatusTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshHostingStatus() async {
    bool hostingStatus = await context.read<ApiClient>().getHostingStatus();
    _hostingStatusNotifier.value = hostingStatus; // Update the notifier value
  }

  void _startAutomaticRefresh() {
    _hostingStatusTimer = Timer.periodic(Duration(seconds: 10), (_) {
      _refreshHostingStatus();
    });
  }

  Future<void> _updateCorrectAnswersCount() async {
    await context.read<ApiClient>().updateUserCorrectAnswersCount(correctAnswers);
  }

  void _nextQuestion() async {
    setState(() {
      final questionState = context.read<QuestionBloc>().state;
      if (questionState is QuestionLoaded) {
        final question = questionState.questions[questionIndex];
        if (selectedAnswer == question.correctAnswer) {
          correctAnswers++;
        }
      }
      questionIndex++;
      selectedAnswer = null;
    });

    await _updateCorrectAnswersCount();
  }

  void _reloadQuestions() {
    context.read<QuestionBloc>().add(LoadQuestionsEvent());
    selectedAnswer = 0;
    questionIndex = 0;
    correctAnswers = 0;
    _updateCorrectAnswersCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swing Quest", style: TextStyle(fontSize: 24, color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _reloadQuestions();
              _refreshHostingStatus();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _hostingStatusNotifier, // Listen to the hosting status changes
        builder: (context, hostingStatus, child) {
          if (hostingStatus) {
            return BlocBuilder<QuestionBloc, QuestionState>(
              builder: (context, questionState) {
                if (questionState is QuestionLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (questionState is QuestionLoaded) {
                  final questions = questionState.questions;

                  if (questionIndex < questions.length) {
                    final question = questions[questionIndex];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question.question,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                          ),
                          SizedBox(height: 20),
                          ...List.generate(4, (i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAnswer = i + 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: selectedAnswer == i + 1 ? Colors.blueAccent : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
                                  ],
                                ),
                                child: Text(
                                  question.answers[i],
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text("Next Question", style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Quiz Completed!',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Correct Answers: $correctAnswers/${questions.length}',
                              style: TextStyle(fontSize: 22, color: Colors.black54),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _reloadQuestions,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text("Restart Quiz", style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else if (questionState is QuestionError) {
                  return Center(child: Text('Error: ${questionState.message}', style: TextStyle(color: Colors.red)));
                }
                return Center(child: Text('Press to Load Questions'));
              },
            );
          } else {
            return Center(child: Text('Hosting is not active 😥📶', style: TextStyle(fontSize: 18, color: Colors.red)));
          }
        },
      ),
    );
  }
}

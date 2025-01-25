import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/pages/homePage.dart';
import 'package:swing_quest/questionBloc/question_Bloc.dart';
import 'package:swing_quest/questionBloc/repository/questionRepository.dart';
import 'package:swing_quest/userBloc/repository/userRepository.dart';
import 'package:swing_quest/userBloc/user_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.dioClient,
    required this.apiClient,
  });

  final DioClient dioClient;
  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(apiClient: apiClient),
        ),
        RepositoryProvider<QuestionRepository>(
          create: (context) => QuestionRepositoryImpl(apiClient: apiClient),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Provide UserBloc with the correct repository
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(), // Ensure repository is read from context
            ),
          ),
          // Provide QuestionBloc with the correct repository
          BlocProvider<QuestionBloc>(
            create: (context) => QuestionBloc(
              questionRepository: context.read<QuestionRepository>(), // Ensure repository is read from context
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Swing Quest',
          home: Homepage(), // Make sure Homepage is using the correct context
        ),
      ),
    );
  }
}

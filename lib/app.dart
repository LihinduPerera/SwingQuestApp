import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/api_client.dart';
import 'package:swing_quest/api_handler.dart';
import 'package:swing_quest/dioClient.dart';
import 'package:swing_quest/pages/homePage.dart';
import 'package:swing_quest/userBloc/userRepository.dart';
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Swing Quest',
          home: Homepage(),
        ),
      ),
    );
  }
}
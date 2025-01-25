import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/userBloc/user_bloc.dart';
import 'package:swing_quest/userBloc/user_event.dart';
import 'package:swing_quest/userBloc/user_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadAllUsersEvent());
  }

  void _refreshData() {
    context.read<UserBloc>().add(LoadAllUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swing Quest"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.user.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = state.user[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.correctAnswersCount?.toString() ?? 'No count'), // Handle null
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No users available.'));
        },
      ),
    );
  }
}
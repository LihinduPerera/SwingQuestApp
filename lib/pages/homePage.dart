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
    // Dispatch the LoadAllUsersEvent when the page loads
    context.read<UserBloc>().add(LoadAllUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swing Quest"),
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
                    itemCount: state.user.length, // Length of the list of users
                    itemBuilder: (BuildContext context, int index) {
                      final user = state.user[index]; // Get user at index
                      return ListTile(
                        title: Text(user.name), // Display user name
                        subtitle: Text(user.answer), // Display user answer
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

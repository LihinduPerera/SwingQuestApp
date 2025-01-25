import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/userBloc/repository/userRepository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadAllUsersEvent>((event, emit) async {
      emit(UserLoading()); 
      try {
        final users = await userRepository.getAllUsers();
        
        print('Loaded users: $users');
        
        emit(UserLoaded(user: users)); 
      } catch (e) {
        emit(UserError(message: e.toString())); 
      }
    });
  }
}
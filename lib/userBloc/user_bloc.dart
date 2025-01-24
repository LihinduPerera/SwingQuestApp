
// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UserRepository _userRepository;

//   UserBloc({required UserRepository userRepository}) 
//   :  _userRepository = userRepository, 
//   super(UserInitial()) {
//      {
//       on<LoadAllUsersEvent>(_onLoadAllUsers);
//     }
//   }
//   Future<void> _onLoadAllUsers(
//     LoadAllUsersEvent event,
//     Emitter<UserState> emit,
//   ) async {
//     try {
//       emit(UserLoading());
//       // debugPrint('Loading monthly crashes for year: ${event.year}');

//       final user =
//           await _userRepository.getAllUsers();

//       emit(UserLoaded(user));
//       // debugPrint('Monthly crashes loaded successfully');
//     } catch (e) {
//       // debugPrint('Error loading monthly crashes: $e');
//       emit(UserError(e.toString()));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swing_quest/userBloc/userRepository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    // Register the event handler here
    on<LoadAllUsersEvent>((event, emit) async {
      emit(UserLoading()); // Emit loading state before fetching data
      try {
        final users = await userRepository.getAllUsers(); // Fetch the users
        emit(UserLoaded(user: users)); // Emit loaded state with fetched users
      } catch (e) {
        emit(UserError(message: e.toString())); // Emit error state if something fails
      }
    });
  }
}

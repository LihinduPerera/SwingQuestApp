// part of 'user_bloc.dart';

// import 'package:equatable/equatable.dart';

// abstract class UserEvent extends Equatable{
//   const UserEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoadAllUsersEvent extends UserEvent {
//   const LoadAllUsersEvent ();
// }
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllUsersEvent extends UserEvent {}
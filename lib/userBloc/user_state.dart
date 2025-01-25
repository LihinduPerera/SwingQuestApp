// part of 'user_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:swing_quest/models/testModel.dart';

// abstract class UserState extends Equatable {
//   const UserState();

//   @override
//   List<Object?> get props => [];
// }

// class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class UserLoaded extends UserState {
//   // final User user;

//   // const UserLoaded(this.user);

//   // @override
//   // List<Object> get props => [user];
//   final List<User> user; // This should be a List<User>
  
//   UserLoaded(this.user);
// }

// class UserError extends UserState {
//   final String message;

//   const UserError (this.message);

//   @override
//   List<Object> get props => [message];
// }
import 'package:equatable/equatable.dart';
import 'package:swing_quest/models/userModel.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> user;

  UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object> get props => [message];
}

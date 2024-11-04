import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnUserLoginEvent extends LoginEvent {
  String email;
  String password;

  OnUserLoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [];
}

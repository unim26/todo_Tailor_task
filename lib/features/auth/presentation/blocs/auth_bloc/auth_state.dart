import 'package:equatable/equatable.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  //variables
  final bool? response;
  final UserModel? user;
  final String? errorMessage;

  //constructure
  const AuthState({this.errorMessage, this.response, this.user});

  //props
  @override
  List<Object?> get props => [errorMessage, response, user];
}

//intial state
class InitialState extends AuthState {
  const InitialState();
}

//loading state
class LoadingState extends AuthState {
  const LoadingState();
}

//success state
class SuccessState extends AuthState {
  const SuccessState(UserModel? user, bool? response)
    : super(errorMessage: null, user: user, response: response);
}

//error state
class ErrorState extends AuthState {
  const ErrorState(String errorMessage)
    : super(errorMessage: errorMessage, user: null, response: null);
}

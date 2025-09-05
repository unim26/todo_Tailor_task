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
class AuthInitialState extends AuthState {
  const AuthInitialState();
}

//loading state
class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

//success state
class AuthSuccessState extends AuthState {
  const AuthSuccessState(UserModel? user, bool? response)
    : super(errorMessage: null, user: user, response: response);
}

//error state
class AuthErrorState extends AuthState {
  const AuthErrorState(String errorMessage)
    : super(errorMessage: errorMessage, user: null, response: null);
}

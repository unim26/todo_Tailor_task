import 'package:equatable/equatable.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

abstract class UserAuthState extends Equatable {
  //variables
  final bool? response;
  final UserModel? user;
  final String? errorMessage;

  //constructure
  const UserAuthState({this.errorMessage, this.response, this.user});

  //props
  @override
  List<Object?> get props => [errorMessage, response, user];
}

//intial state
class AuthInitialState extends UserAuthState {
  const AuthInitialState();
}

//loading state
class AuthLoadingState extends UserAuthState {
  const AuthLoadingState();
}

//signout state
class AuthSignOutState extends UserAuthState {
  const AuthSignOutState();
}

//success state
class AuthSuccessState extends UserAuthState {
  const AuthSuccessState(UserModel? user, bool? response)
    : super(errorMessage: null, user: user, response: response);
}

//error state
class AuthErrorState extends UserAuthState {
  const AuthErrorState(String errorMessage)
    : super(errorMessage: errorMessage, user: null, response: null);
}

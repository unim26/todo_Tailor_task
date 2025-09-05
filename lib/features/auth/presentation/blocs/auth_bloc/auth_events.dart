import 'package:todo/features/auth/data/models/user_model.dart';

abstract class AuthEvents {
  const AuthEvents();
}

//sign in with google event
class SignInWithGoogleEvent extends AuthEvents {}

//signout event
class SignOutEvent extends AuthEvents {}

//get current user event
class GetCurrentUserEvent extends AuthEvents {}

//is new user event
class IsNewUserEvent extends AuthEvents {}

//create new user event
class CreateNewUserEvent extends AuthEvents {
  final UserModel user;

  CreateNewUserEvent({required this.user});
}

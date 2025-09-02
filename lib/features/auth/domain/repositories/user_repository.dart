import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  //method to sign in with google
  Future<Datastate<bool>> signInWithGoogle();

  //method to sign out
  Future<Datastate<bool>> signOut();

  //method to get current user
  Future<Datastate<UserEntity>> getCurrentUser();

  //method to check for new user
  Future<Datastate<bool>> isNewUser();

  //method to create a new user
  Future<Datastate<bool>> createUser(UserEntity user);
}

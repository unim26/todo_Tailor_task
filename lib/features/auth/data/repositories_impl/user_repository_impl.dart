import 'package:todo/core/resources/datastate.dart';
import 'package:todo/features/auth/data/data_services/user_data_service.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  //user data service
  final UserDataService _userDataService;

  //constructor
  UserRepositoryImpl(this._userDataService);

  //create user
  @override
  Future<Datastate<bool>> createUser(UserModel user) async {
    try {
      final response = await _userDataService.createUser(user);

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("something went wrong while creating user");
      }
    } catch (e) {
      print('Error creating user: $e');
      return DataFailed("something went wrong while creating user");
    }
  }

  //get current user
  @override
  Future<Datastate<UserModel>> getCurrentUser() async {
    try {
      final response = await _userDataService.getCurrentUser();

      //check if response is null
      if (response != null) {
        return DataSuccess(UserModel.fromJson(response.toJson()));
      } else {
        return DataFailed("no user found");
      }
    } catch (e) {
      print('Error getting current user: $e');
      return DataFailed("something went wrong while getting current user");
    }
  }

  //is new user
  @override
  Future<Datastate<bool>> isNewUser() async {
    try {
      final response = await _userDataService.isNewUser();

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed('error checking  user status');
      }
    } catch (e) {
      print('Error checking if user is new: $e');
      return DataFailed("something went wrong while checking if user is new");
    }
  }

  //sign in with google
  @override
  Future<Datastate<bool>> signInWithGoogle() async {
    try {
      final response = await _userDataService.loginWithGoogle();

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("error signing in with Google");
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      return DataFailed("something went wrong while signing in with Google");
    }
  }

  //sign out
  @override
  Future<Datastate<bool>> signOut() async {
    try {
      final response = await _userDataService.logout();

      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("error signing out");
      }
    } catch (e) {
      print('Error signing out: $e');
      return DataFailed("something went wrong while signing out");
    }
  }

  @override
  Future<Datastate<bool>> updateFcmToken(String fcmToken) async {
    try {
      final response = await _userDataService.updateFcmToken(fcmToken);
      if (response) {
        return DataSuccess(true);
      } else {
        return DataFailed("error updating fcm token");
      }
    } catch (e) {
      print('Error updating fcm token: $e');
      return DataFailed("something went wrong while updating fcm token");
    }
  }
}

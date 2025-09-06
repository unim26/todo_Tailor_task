import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

class UserDataService {
  //supabase client
  final SupabaseClient supabaseClient = Supabase.instance.client;

  //method to login user with google
  Future<bool> loginWithGoogle() async {
    try {
      //client id and server id from google cloud console
      final String clientId =
          '1051586636236-o7l4dkbuh6n0qfplp772oo1mp48mvvfa.apps.googleusercontent.com';
      final String serverId =
          '1051586636236-ghsun1i09ka5e8sl2eiovr2rbd9q6tvg.apps.googleusercontent.com';

      //initialize google sign in
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      //configure google sign in
      await googleSignIn.initialize(
        clientId: clientId,
        serverClientId: serverId,
      );

      //authenticate user
      final GoogleSignInAccount account = await googleSignIn.authenticate();

      //get id token
      final String id = account.authentication.idToken!;

      //sign in with supabase
      await supabaseClient.auth
          .signInWithIdToken(provider: OAuthProvider.google, idToken: id)
          .then((onValue) => true)
          .catchError((onError) => false);

      return true;
    } catch (e) {
      print('Error logging in with Google: $e');
      return false;
    }
  }

  //method to logout user
  Future<bool> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
      await supabaseClient.auth.signOut();
      return true;
    } catch (e) {
      print('Error logging out: $e');
      return false;
    }
  }

  //method to get current user
  Future<User?> getCurrentUser() async {
    try {
      final User? user = supabaseClient.auth.currentUser;
      return user;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  //method to check if user is new
  Future<bool> isNewUser() async {
    try {
      //get current user
      final User? currentUser = supabaseClient.auth.currentUser;

      //get user detail from db
      final dbUser =
          await supabaseClient
              .from('Users')
              .select('id')
              .eq('id', currentUser!.id)
              .maybeSingle();

      return dbUser == null;
    } catch (e) {
      print('Error checking if user is new: $e');
      return false;
    }
  }

  //method to create new user in db
  Future<bool> createUser(UserModel user) async {
    try {
      await supabaseClient.from('Users').insert(user.toJson());
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }

  }
    //method to updade fcm token to user profile
    Future<bool> updateFcmToken(String fcmToken) async {
      try {
        final User? currentUser = supabaseClient.auth.currentUser;

        await supabaseClient
            .from('Users')
            .update({'fcm_token': fcmToken})
            .eq('id', currentUser!.id);

        return true;
      } catch (e) {
        print('Error updating FCM token: $e');
        return false;
      }
    }
}

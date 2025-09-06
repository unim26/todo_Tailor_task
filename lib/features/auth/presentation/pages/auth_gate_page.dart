import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/core/resources/datastate.dart';
import 'package:todo/core/utils/components/app_loading_indicator.dart';
import 'package:todo/dependency_injection.dart';
import 'package:todo/features/auth/domain/usecases/check_for_new_user_usecase.dart';

class AuthGatePage extends StatefulWidget {
  const AuthGatePage({super.key});

  @override
  State<AuthGatePage> createState() => _AuthGatePageState();
}

class _AuthGatePageState extends State<AuthGatePage> {
  @override
  void initState() {
    _checkUserStatus();

    super.initState();
  }

  void _checkUserStatus() {
    //supabase client
    final SupabaseClient supabase = Supabase.instance.client;
    //listen for authstate changes
    supabase.auth.onAuthStateChange.listen((onData) async {
      final AuthChangeEvent event = onData.event;
      final Session? session = supabase.auth.currentSession;
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.tokenRefreshed) {
        //check if user is new
        final CheckForNewUserUsecase checkForNewUserUsecase =
            locator<CheckForNewUserUsecase>();

        final datastate = await checkForNewUserUsecase.call(null);

        if (datastate is DataSuccess) {
          //extract user detail
          final newUser = Supabase.instance.client.auth.currentUser;
          print("user data : ${newUser?.userMetadata}");

          //navigate to next page
          Get.offAllNamed(
            '/user-profile-build-page',
            arguments: {'user': newUser},
          );
        } else {
          //navigate
          Get.offAllNamed('/');
        }
      } else if (event == AuthChangeEvent.initialSession) {
        if (session != null) {
          // user is already logged in
          Get.offAllNamed('/');
        } else {
          // no session, show login
          Get.offAllNamed('/login-page');
        }
      } else if (event == AuthChangeEvent.signedOut) {
        Get.offAllNamed('/login-page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppLoadingIndicator(message: 'Loading....')),
    );
  }
}

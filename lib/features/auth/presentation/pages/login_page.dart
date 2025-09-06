import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/core/utils/components/app_button.dart';
import 'package:todo/core/utils/components/app_loading_indicator.dart';
import 'package:todo/core/utils/components/app_snacbar.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //size
    final Size sSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        //body
        body: BlocConsumer<AuthBloc, UserAuthState>(
          listener: (context, state) async {
            //error state
            if (state is AuthErrorState) {
              //show snacbar
              appSnacBar(context, message: state.errorMessage!, type: "error");
            }

            //loggedin state
            if (state is AuthSuccessState) {
              //show snacbar
              appSnacBar(
                context,
                message: "Logged in successfully......",
                type: "success",
              );

              //
              Get.toNamed('/');
            }
          },
          builder: (context, state) {
            //loading state
            if (state is AuthLoadingState) {
              return const AppLoadingIndicator(
                message: "Please wait logging you in....!",
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //app logo and name
                    Text(
                      'Todo',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text('By'),
                    Text(
                      'Abhishek Kumar',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: sSize.height * 0.3),
                    //text
                    Text(
                      'Welcome to Todo App',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    SizedBox(height: sSize.height * 0.025),

                    //texts
                    Text(
                      'Manage your tasks efficiently and stay organized with our user-friendly Todo App. Sign in to get started!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: sSize.height * 0.15),

                    //google sign in button
                    AppButton(
                      icon: FontAwesomeIcons.google,
                      title: 'signIn with Google',
                      onPressed:
                          () => context.read<AuthBloc>().add(
                            SignInWithGoogleEvent(),
                          ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

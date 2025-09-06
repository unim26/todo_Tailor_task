import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/core/utils/components/app_button.dart';
import 'package:todo/core/utils/components/app_loading_indicator.dart';
import 'package:todo/core/utils/components/app_snacbar.dart';
import 'package:todo/core/utils/components/app_text_field.dart';
import 'package:todo/features/auth/data/models/user_model.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_events.dart';
import 'package:todo/features/auth/presentation/blocs/auth_bloc/auth_state.dart';

class UserProfileBuildPage extends StatefulWidget {
  const UserProfileBuildPage({super.key});

  @override
  State<UserProfileBuildPage> createState() => _UserProfileBuildPageState();
}

class _UserProfileBuildPageState extends State<UserProfileBuildPage> {
  //variables
  late User user;

  //controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //init state
  @override
  void initState() {
    final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
    user = args['user'];

    //assign intial value to controllers
    nameController.text = user.userMetadata!['name'] ?? '';
    emailController.text = user.userMetadata!['email'] ?? '';
    super.initState();
  }

  //handle on submit
  void handleOnSubmit() async {
    //validate fields
    if (nameController.text.isEmpty) {
      appSnacBar(context, message: 'Please Enter your name', type: 'warning');
      return;
    }
    if (emailController.text.isEmpty) {
      appSnacBar(context, message: 'Please Enter your email', type: 'warning');
      return;
    }

    //create user profile
    context.read<AuthBloc>().add(
      CreateNewUserEvent(
        user: UserModel(
          id: user.id,
          name: nameController.text,
          email: emailController.text,
          photoUrl: user.userMetadata!['avatar_url'] ?? '',
          //TODO: add fcm token
          fcmToken: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size sSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthBloc, UserAuthState>(
        listener: (context, state) {
          //error state
          if (state is AuthErrorState) {
            //show error snackbar
            appSnacBar(
              context,
              message: 'Error updating profile',
              type: 'warning',
            );
          }

          //success state
          if (state is AuthSuccessState) {
            //show success snackbar
            appSnacBar(
              context,

              message: 'Profile updated successfully',
              type: 'success',
            );
            //navigate to home page
            Get.offAllNamed('/');
          }
        },
        builder: (context, state) {
          //loading state
          if (state is AuthLoadingState) {
            return Center(
              child: AppLoadingIndicator(message: 'updating profile....'),
            );
          }

          //user profile build page
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //space
                  SizedBox(height: sSize.height * 0.05),
                  //text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Details",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.05),

                  //user image
                  user.userMetadata!['avatar_url'] != null
                      ? CircleAvatar(
                        radius: sSize.width * 0.15,
                        backgroundImage: NetworkImage(
                          user.userMetadata!['avatar_url'],
                        ),
                      )
                      : CircleAvatar(
                        radius: sSize.width * 0.15,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: sSize.width * 0.15,
                          color: Colors.grey[600],
                        ),
                      ),

                  //space
                  SizedBox(height: sSize.height * 0.05),

                  //name field
                  AppTextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    hintText: 'Enter your name',
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.03),

                  //email field
                  AppTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email',
                  ),

                  //space
                  SizedBox(height: sSize.height * 0.05),

                  //submit button
                  AppButton(title: 'Submit', onPressed: () => handleOnSubmit()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:todo/features/auth/presentation/pages/login_page.dart';
import 'package:todo/features/auth/presentation/pages/user_profile_build_page.dart';
import 'package:todo/features/home/presentation/pages/home_page.dart';
import 'package:todo/features/todo/presentation/pages/create_todo_page.dart';
import 'package:todo/main.dart';

class AppRoutes {
  //app routes
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => HomePage(),
    //login page route
    '/login-page': (context) => const LoginPage(),
    //user profile build page route
    '/user-profile-build-page': (context) => const UserProfileBuildPage(),
    //auth gate page route
    '/auth-gate-page': (context) => AuthGatePage(),
    //create todo page route
    '/create-todo-page': (context) => const CreateTodoPage(),
  };
}

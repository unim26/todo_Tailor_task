import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/main.dart';

class AppRoutes {

  //app routes
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
  };
}

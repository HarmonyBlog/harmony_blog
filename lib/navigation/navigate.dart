import 'package:flutter/material.dart';
import 'package:harmony_blog/screens/AuthScreen.dart';
import 'package:harmony_blog/screens/HomeScreen.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => AuthScreen(),
    '/home': (context) => HomeScreen()
  };
}

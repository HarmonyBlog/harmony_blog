import 'package:flutter/material.dart';
import 'package:harmony_blog/screens/AuthScreen.dart';

void main() {
  runApp(HarmonyBlog());
}

class HarmonyBlog extends StatelessWidget {
  const HarmonyBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

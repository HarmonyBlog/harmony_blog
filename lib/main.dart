import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/AuthScreen.dart';
import '/provider/appStateProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => HarmonyBlog(),
    ),
  );
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

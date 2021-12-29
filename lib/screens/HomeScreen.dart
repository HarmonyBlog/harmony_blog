import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:harmony_blog/provider/appStateProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Scaffold(
        backgroundColor: Color(0xfff5ebff),
        body: Center(child: const Text("Home")),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appState.homeTabIndex,
          onTap: appState.sethomeTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

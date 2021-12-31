import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony_blog/screens/AuthScreen.dart';
import 'package:provider/provider.dart';

import 'package:harmony_blog/provider/appStateProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      } else {}
    });

    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Scaffold(
        backgroundColor: Color(0xfff5ebff),
        body: Center(child: appState.view[appState.homeTabIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appState.homeTabIndex,
          onTap: (index) => {
            if (!FirebaseAuth.instance.currentUser!.email!
                    .contains('@student.onlinedegree.iitm.ac.in') &&
                index == 1)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('You Can Only Post With IITM Mail Id')))
              }
            else
              {appState.sethomeTabIndex(index)}
          },
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

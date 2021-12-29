import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    // FirebaseFirestore.instance
    //     .collection('attendees')
    //     .where('attending', isEqualTo: true)
    //     .snapshots()
    //     .listen((snapshot) {
    //   _attendees = snapshot.docs.length;
    //   notifyListeners();
    // });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = false;
      } else {
        _loginState = true;
      }
      notifyListeners();
    });
  }

  bool _loginState = false;
  bool get loginState => _loginState;

  String? _email;
  String? get email => _email;

  int _homeTabIndex = 0;
  int get homeTabIndex => _homeTabIndex;
  void sethomeTabIndex(int index) {
    _homeTabIndex = index;
    notifyListeners();
  }
}

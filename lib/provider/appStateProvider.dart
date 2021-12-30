import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harmony_blog/model/post.dart';
import '../model/post.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((snapshot) {
      _posts = [];
      for (final document in snapshot.docs) {
        _posts.add(
          Post(
            id: document.id,
            createdAt: document.data()['createdAt'] as String,
            imageUrl: document.data()['imageUrl'] as String,
            userId: document.data()['userId'] as String,
            title: document.data()['title'] as String,
            desc: document.data()['desc'] as String,
          ),
        );
      }

      _isPostLoading = false;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = false;
      } else {
        _loginState = true;
      }
      notifyListeners();
    });
  }

  bool _isPostLoading = true;
  bool get isPostLoading => _isPostLoading;

  List<Post> _posts = <Post>[];
  List<Post> get posts => _posts;

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

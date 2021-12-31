import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:harmony_blog/screens/ProfileView.dart';
import 'package:random_string/random_string.dart';

import 'package:harmony_blog/screens/NewPostView.dart';
import 'package:harmony_blog/screens/TimelineView.dart';
import 'package:image_picker/image_picker.dart';
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
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool _isPostLoading = true;
  bool get isPostLoading => _isPostLoading;

  List<Post> _posts = <Post>[];
  List<Post> get posts => _posts;

  int _homeTabIndex = 0;
  int get homeTabIndex => _homeTabIndex;
  void sethomeTabIndex(int index) {
    _homeTabIndex = index;
    notifyListeners();
  }

  // Create Post
  String title = '', desc = '';
  File? _selectedImage = null;
  File? get selectedImage => _selectedImage;
  bool _isCreateLoading = false;
  bool get isCreateLoading => _isCreateLoading;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _selectedImage = File(image!.path);
    notifyListeners();
  }

  Future uploadBlog() async {
    if (selectedImage != null) {
      _isCreateLoading = true;
      notifyListeners();

      /// uploading image to firebase storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      try {
        await ref.putFile(selectedImage!);
      } catch (e) {
        // e.g, e.code == 'canceled'
      }
      var downloadUrl = await ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        "imageUrl": downloadUrl,
        "title": title,
        "desc": desc,
        "userId": FirebaseAuth.instance.currentUser!.uid
      };
      try {
        FirebaseFirestore.instance.collection("posts").add(blogMap);
      } catch (e) {
        print(e);
      }
      sethomeTabIndex(0);
      _isCreateLoading = false;
      notifyListeners();
    } else {}
  }

  List<Widget> view = [TimelineView(), NewPostView(), ProfileView()];
}

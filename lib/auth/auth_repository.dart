
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/auth/common_firebase_storage.dart';
import 'package:project_insta/model/comment_model.dart';
import 'package:project_insta/model/postmodel.dart';
import 'package:project_insta/model/usermodel.dart';
import 'package:project_insta/screens/home_screen.dart';
import 'package:project_insta/show_snackbar.dart';
import 'package:uuid/uuid.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance);
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({required this.auth, required this.firebaseFirestore});
  String postId = Uuid().v1();
 var commentId = Uuid().v1();

  void saveCommentsDataToFirebase ({
    required BuildContext context,
    required String profilePic,
    required String userName,
    required String uid,
    required String commentText,
    required String postId,

  })async{
    try {
     
  
      var comment = CommentModel(uid: uid, postId: postId, commentId: commentId, commentText: commentText, profilePic: profilePic, userName: userName, time: DateTime.now(), likes: []);
    
    await firebaseFirestore.collection('post').doc(auth.currentUser!.uid).collection('comment').doc(commentId).set(comment.toMap());
    
    } catch (e) {
      showSnackBar(context,e.toString());
    }

  }

  void getName() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .get();
    print(snap.data());
  }



  Stream <List<PostModel>> getPostData(){
    return firebaseFirestore.collection('post').snapshots().map((event) {
      List<PostModel> postData = [];
      for (var document in event.docs) {
        postData.add(PostModel.fromMap(document.data()));
      }
      return postData;
    });
  }

  Stream<List<UserModel>> getUserData() {
    return firebaseFirestore.collection('user').snapshots().map((event) {
      List<UserModel> userdata = [];
      for (var document in event.docs) {
        userdata.add(UserModel.fromMap(document.data()));
      }
      print(userdata);
      return userdata;
    });
  }

  void loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MobileLayoutScreen(),
              )));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MobileLayoutScreen(),
              )));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void savePostDataToFirebase(
      {required ProviderRef ref,
      required BuildContext context,
      required String description,
      required String uid,
      required File postimage,
      required String profilePic,
      required String userName}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = await ref
          .read(CommonFirebaseStorageRespositoryProvider)
          .storeFileToFirebase('Posts', postimage,true);
    
      var post = PostModel(
          description: description,
          userName: userName,
          uid: uid,
          profilePic: profilePic,
          postPic: photoUrl,
          postId: postId,
          publishedTime: DateTime.now(),
          likes: 0);

          firebaseFirestore.collection('post').doc(auth.currentUser!.uid).set(post.toMap());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void saveUserDataToFirebase(
      {required File? profilePic,
      required BuildContext context,
      required ProviderRef ref,
      required String email,
      required String name,
      required String password,
      required String bio}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-15.jpg';

      if (profilePic != null) {
        photoUrl = await ref
            .read(CommonFirebaseStorageRespositoryProvider)
            .storeFileToFirebase('profilePic', profilePic,false);
      }

      var user = UserModel(
          profilePic: photoUrl,
          email: email,
          password: password,
          name: name,
          bio: bio,
          uid: uid,
          followers: [],
          following: []);
      firebaseFirestore.collection('user').doc(uid).set(user.toMap());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Stream <List<CommentModel>> getCommentData (){
  return firebaseFirestore.collection('post').doc(auth.currentUser!.uid).collection('comment').snapshots().map((event) {
    List<CommentModel> comment = [];
    for (var document in event.docs) {

      comment.add(CommentModel.fromMap(document.data()));

    }
    print(comment);
    return comment;
    
  });
}
}

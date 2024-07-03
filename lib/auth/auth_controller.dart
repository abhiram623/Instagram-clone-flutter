import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/auth/auth_repository.dart';
import 'package:project_insta/model/comment_model.dart';
import 'package:project_insta/model/postmodel.dart';
import 'package:project_insta/model/usermodel.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(authRepository: ref.read(authRepositoryProvider), ref: ref,);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController( {required this.authRepository,required this.ref,});

  void getName (){
     authRepository.getName();
  }

  Stream<List<UserModel>> getUserData (){
   return authRepository.getUserData();
  }
  Stream <List<PostModel>> getPostData(){
    return authRepository.getPostData();
  }
  Stream <List<CommentModel>> getCommentData(){
    return authRepository.getCommentData();
  }

  void loginUser (String email,String password,BuildContext context){
    authRepository.loginWithEmailAndPassword(email, password, context);
  }

  void createUser(String email,String password,BuildContext context){
    authRepository.createUserWithEmailAndPassword(email, password, context);
  }

  void saveUserDataToFirebase (File? profilePic,  BuildContext context, String email, String name, String password, String bio){
    authRepository.saveUserDataToFirebase(profilePic: profilePic, context: context, ref: ref, email: email, name: name, password: password, bio: bio);
  }
  void savePostDataToFirebase({
      required BuildContext context,
      required String description,
      required String uid,
      required File postimage,
      required String profilePic,
      required String userName}){
    authRepository.savePostDataToFirebase(ref: ref, context: context, description: description, uid: uid, postimage: postimage, profilePic: profilePic, userName: userName);
  }
  void saveCommentsDataToFirebase(  
    BuildContext context,
     String profilePic,
     String userName,
     String uid,
    String commentText,
     String postId,){
    authRepository.saveCommentsDataToFirebase(context: context, profilePic: profilePic, userName: userName, uid: uid, commentText: commentText, postId: postId);
  }
  
}
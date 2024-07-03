import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final CommonFirebaseStorageRespositoryProvider = Provider((ref) {
  return CommonFirebaseStorageRespository(firebaseStorage: FirebaseStorage.instance);
});

class CommonFirebaseStorageRespository{
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRespository({required this.firebaseStorage});

  Future<String> storeFileToFirebase (String childName,File file,bool isPost)async{
     Reference reference = firebaseStorage.ref().child(childName).child(FirebaseAuth.instance.currentUser!.uid);
   if (isPost) {
     String id = Uuid().v1();
     reference = reference.child(id);
   }
   
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snap =  await uploadTask;
    String downLoadUrl =await snap.ref.getDownloadURL();
    return downLoadUrl;
  }
}
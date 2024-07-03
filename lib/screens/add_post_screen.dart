import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_insta/auth/auth_controller.dart';
import 'package:project_insta/show_snackbar.dart';
import 'package:project_insta/utils/colors.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  @override
  void initState() {
   getUserData();
    super.initState();
  }
  File? file;
  String userName = '';
  String profilePic = '';
  String uid = '';
  bool isLoading =  false;
  TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
   descriptionController.dispose();
    super.dispose();
  }

  void selectImage(){
 showDialog(context: context, builder: (context) {
   return SimpleDialog(
    title: Text("Create a Post"),
    children: [
      SimpleDialogOption(
        child: Text("Take a Photo"),
          onPressed: () async{
            Navigator.of(context).pop();
               file =    await pickImageFromgallery(context, ImageSource.camera);  
               setState(() {
                 
               });                                                                                                     
          },
          
      ),
      SimpleDialogOption(
        child: Text("Choose From Gallery"),
          onPressed: () async{
            Navigator.of(context).pop();
               file =    await pickImageFromgallery(context, ImageSource.gallery);  
               setState(() {
                 
               });                                                                                                     
          },
          
      ),
        SimpleDialogOption(
        child: Text("Cancel"),
          onPressed: () async{
            Navigator.of(context).pop();
                                                                                                                
          },
          
      ),
    ],
    );
 },);
    
  }

   void getUserData ()async{
    try {
      DocumentSnapshot snap =  await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

setState(() {
  userName = (snap.data() as Map<String,dynamic>)['name'];
  profilePic = (snap.data() as Map<String,dynamic>)['profilePic'];
  uid = (snap.data() as Map<String,dynamic>)['profilePic'];
});
    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }
  void clearImage (){
    setState(() {
      file  = null;
    });
  }

  void postimage (String userName,String profilePic,String uid)async{
    setState(() {
      isLoading = true;
    });
try {
  ref.read(authControllerProvider).savePostDataToFirebase(context: context, description: descriptionController.text, uid: uid, postimage: file!, profilePic: profilePic, userName: userName);
setState(() {
  isLoading = false;
});
showSnackBar(context, "Posted");
clearImage();
} catch (e) {
  setState(() {
    isLoading = false;
  });
   showSnackBar(context, e.toString());
}
  }
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return file == null ? Scaffold(
      body: Center(child: IconButton(onPressed: (){selectImage();}, icon: Icon(Icons.upload),)),
    ):
    Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(onPressed: clearImage, icon: Icon(Icons.arrow_back)),
        title: Text("Post to"),
        actions: [
          TextButton(onPressed: (){postimage(userName, profilePic, uid);}, child: Text("Post",style: TextStyle(color: Colors.blueAccent),))
        ],
      ),
      body: Column(
        children: [
          isLoading ? CircularProgressIndicator() : Container(),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilePic),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: width *0.45 ,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a caption"),
              )),
              SizedBox(width: 10,),
              Container(width: 50,height: 50,
              decoration: BoxDecoration(image: DecorationImage(
                fit: BoxFit.fill,
                image:FileImage(file!))),),
          Divider()
          ],
        )],
      ),
    );
  }
}
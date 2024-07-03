import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_insta/auth/auth_controller.dart';
import 'package:project_insta/screens/login_screen.dart';
import 'package:project_insta/show_snackbar.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? image;

  @override
  void dispose() {
   emailController.dispose();
   passController.dispose();
   nameController.dispose();
   bioController.dispose();
    super.dispose();
  }

  void selectimage ()async{
    image = await pickImageFromgallery(context,ImageSource.gallery);
    setState(() {
      
    });
  }

  void signInwithEmailAndPassword ()async{

    ref.read(authControllerProvider).createUser(emailController.text, passController.text, context);
    ref.read(authControllerProvider).saveUserDataToFirebase(image, context, emailController.text, nameController.text, passController.text, bioController.text);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              
              children: [
                SizedBox(height: 20,),
                Stack(
                  children: [
                   image == null ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-15.jpg"),
                    ) : CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(image!)
                    ),
                      
                    Positioned(
                      bottom: -10,right: -15,
                      child: IconButton(onPressed: (){selectimage();}, icon: Icon(Icons.add_a_photo,color: Colors.blue,)))
                  ],
                ),
                SizedBox(height: 31,),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) ),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) )
                    ),
                  )),
                  SizedBox(height: 31,),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) ),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) )
                    ),
                  )),
                  SizedBox(height: 31,),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) ),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) )
                    ),
                  )),
                  SizedBox(height: 31,),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Bio",
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) ),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) )
                    ),
                  )),
              
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
                    onPressed: (){
                      signInwithEmailAndPassword();
                    }, child: Text("Login In")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account"),
                        TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginScreen(),));
                        }, child: Text('Login'))
                      ],
                    )
              ],
              ),
            ),
          ),
        )
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/auth/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  
void loginUser ()async{
  ref.read(authControllerProvider).loginUser(loginEmailController.text, loginPasswordController.text, context);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,height: double.infinity,
          child: Center(
            child: Column(
            
            children: [
              SizedBox(height: 20,),
              
              SizedBox(height: 31,),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: loginEmailController,
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
                  controller: loginPasswordController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) ),
                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(width: 2,color: Colors.white) )
                  ),
                )),
                SizedBox(height: 31,),
              

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
                  onPressed: (){
          loginUser();
                  }, child: Text("Login In"))
            ],
            ),
          ),
        )
        ),
    );
  }
}
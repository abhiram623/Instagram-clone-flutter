import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/screens/add_post_screen.dart';
import 'package:project_insta/screens/home_screen.dart';
import 'package:project_insta/screens/sign_in_screen.dart';
import 'package:project_insta/utils/colors.dart';
import 'firebase_options.dart';
void main() async{


// ...
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ProviderScope(child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Insta',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor:mobileBackgroundColor ),
      home:
      MobileLayoutScreen()
      // SignInScreen(),
    );
  }
}

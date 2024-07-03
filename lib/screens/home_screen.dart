import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/screens/add_post_screen.dart';
import 'package:project_insta/screens/grocery_screen.dart';
import 'package:project_insta/screens/post_screen.dart';
import 'package:project_insta/show_snackbar.dart';
import 'package:project_insta/utils/colors.dart';


class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen> {

  String userName =  '';
  late PageController pageController;
  @override
  void initState() {
   
    pageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

 
int _page = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(children: [
        PostScreen(),
        PostScreen(),
        AddPostScreen(),
        Center(child: Text('Fav'),),
        Center(child: Text('Person'),),
      ],
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          _page = value;
        });
      },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap:(value) {
          pageController.jumpToPage(value);
        },
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: _page ==0 ?secondaryColor : primaryColor,),
            label: '',
            backgroundColor: primaryColor
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.search,color: _page ==1 ?secondaryColor : primaryColor,),
            label: '',
             backgroundColor: primaryColor
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,color: _page ==2 ?secondaryColor : primaryColor,),
            label: '',
             backgroundColor: primaryColor
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: _page ==3 ?secondaryColor : primaryColor,),
            label: '',
             backgroundColor: primaryColor
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.person,color: _page ==4 ?secondaryColor : primaryColor,),
            label: '',
             backgroundColor: primaryColor
            ),
        ]
        ),
    );
  }
}
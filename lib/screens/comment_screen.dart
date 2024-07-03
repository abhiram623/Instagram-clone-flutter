import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:project_insta/auth/auth_controller.dart';
import 'package:project_insta/model/comment_model.dart';
import 'package:project_insta/show_snackbar.dart';

class CommentScreen extends ConsumerStatefulWidget{
  const CommentScreen(this.postId, {super.key});
  final String postId;

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  String userName = '';
  String profilePic = '';
  String uid = '';
  final TextEditingController commentTextController = TextEditingController();

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

   void getUserData (BuildContext context)async{
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
  @override
  void initState() {
   getUserData(context);
    super.initState();
  }

void sendComment ()async{
  ref.read(authControllerProvider).saveCommentsDataToFirebase(context, profilePic, userName, uid, commentTextController.text, widget.postId);

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
        title: Text("Comments",style: TextStyle(color: Colors.black),),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('$profilePic'),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: commentTextController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Add your comment as username"),
              ),
            )),
            TextButton(onPressed: (){sendComment();}, child: Text("Post"))
          ],
        ),
      ),
      body: StreamBuilder<List<CommentModel>>(
        stream: ref.read(authControllerProvider).getCommentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center( child:  CircularProgressIndicator(),);
          }
          
          // return ListView(
          //   children: [
          //     ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: snapshot.data!.length,
          //       scrollDirection: Axis.vertical,
          //       itemBuilder: (context, index) {
          //       return ListTile(title: Text("hh",style: TextStyle(color: Colors.black),),);
          //     },)
          //   ],
          // );
          return Column(
            children: [
              ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder:(context, index) {
                return ListTile(
                     leading:  CircleAvatar(
                      backgroundImage: NetworkImage(profilePic),
                    ),
                  title: Row(
                    children: [
                      Text(userName,style: TextStyle(color: Colors.black),),
                      SizedBox(width: 5,),
                      Text(DateFormat.yMMM().format(snapshot.data![index].time),style: TextStyle(color: Colors.grey,fontSize: 15),),
                    ],
                  ),
                  subtitle: Text(snapshot.data![index].commentText,style: TextStyle(color: Colors.black),),
                  trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,color: Colors.black,)),
                );
              },),
            ],
          );
        }
      ),
    );
  }
}
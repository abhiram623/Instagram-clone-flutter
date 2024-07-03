import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_insta/auth/auth_controller.dart';
import 'package:project_insta/model/postmodel.dart';
import 'package:intl/intl.dart';
import 'package:project_insta/screens/comment_screen.dart';


class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.black,size: 30,))
        ],
       title: Image(
        width: 150,
        fit: BoxFit.cover,
        image: NetworkImage("https://th.bing.com/th/id/OIP.DexBeSiGPUP4igHscKierwHaCi?w=308&h=120&c=7&r=0&o=5&dpr=1.3&pid=1.7")),
        
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,height: 100,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(70),color: Colors.blue,
                  gradient: LinearGradient(colors: [
                    Colors.pink,
                    Colors.blue
                  ])
                  ),
                  height: 30,width: 80,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-15.jpg'),
                    radius: 30,
                    
                  ),
                ),
              );
            },),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,height: 636.2,
              child: StreamBuilder<List<PostModel>>(
                stream: ref.read(authControllerProvider).getPostData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                    itemCount:snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder:(context, index) {
                      var postData = snapshot.data![index];
                    return Container(
                    width: double.infinity,
                    height: 715,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                         Container(
                          padding: EdgeInsets.all(4),
                          height: 70,width: 70,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            gradient: LinearGradient(colors: [
                               Colors.pink,
                              Colors.blue
                            ]),
                            borderRadius: BorderRadius.circular(60),
                            
                          ),
                          child:  CircleAvatar(
                            radius: 29,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage: NetworkImage(postData.profilePic),
                            ),
                          ),
                         ),
                         SizedBox(width: 10,),
                         Text(postData.userName,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),),
                         SizedBox(width: 191,),
                         IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined,color: Colors.black,))
                        ],),
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        
                        decoration: BoxDecoration(color: Colors.white, image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(postData.postPic))),
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,size: 35,color: Colors.black,)),
                          IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder:(context) =>CommentScreen(postData.postId) ,));
                          }, icon: Icon(Icons.mode_comment_outlined,size: 35,color: Colors.black,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.send_outlined,size: 35,color: Colors.black,)),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_add_outlined,size: 35,color: Colors.black,)),
                      ],),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("1224 likes",style: TextStyle(fontSize: 17,color: Colors.black),),
                        )),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                text: postData.userName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                              TextSpan(
                                text: "  ${postData.description}",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),
                              )
                            ]
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("View all 200 comments",style: TextStyle(color: Colors.grey),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(DateFormat.Hm().format(postData.publishedTime),style: TextStyle(color: Colors.grey),)),
                        )
                    ],),
                          
                  );
                  },);
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}

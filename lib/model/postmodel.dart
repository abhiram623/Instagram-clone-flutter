class PostModel {
  final String description;
  final String userName;
  final String uid;
  final String profilePic;
  final String postPic;
  final String postId;
  final DateTime publishedTime;
  final int likes;

  PostModel({
    required this.description,
    required this.userName,
    required this.uid,
    required this.profilePic,
    required this.postPic,
    required this.postId,
    required this.publishedTime,
    required this.likes,
  });

  // Method to convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'userName': userName,
      'uid': uid,
      'profilePic': profilePic,
      'postPic': postPic,
      'postId': postId,
      'publishedTime': publishedTime.toIso8601String(),
      'likes': likes,
    };
  }

  // Method to create an object from a map
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      description: map['description'],
      userName: map['userName'],
      uid: map['uid'],
      profilePic: map['profilePic'],
      postPic: map['postPic'],
      postId: map['postId'],
      publishedTime: DateTime.parse(map['publishedTime']),
      likes: map['likes'],
    );
  }
}
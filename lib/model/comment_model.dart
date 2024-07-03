class CommentModel {
  final String uid;
  final String postId;
  final String commentId;
  final String commentText; // Corrected the naming to follow Dart conventions
  final String profilePic;
  final String userName;
  final DateTime time;
  final List likes;

  CommentModel({
    required this.uid,
    required this.postId,
    required this.commentId,
    required this.commentText,
    required this.profilePic,
    required this.userName,
    required this.time,
    required this.likes,
  });

  // Convert a Comment object into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'postId': postId,
      'commentId': commentId,
      'commentText': commentText,
      'profilePic': profilePic,
      'userName': userName,
      'time': time.toIso8601String(),
      'likes': likes,
    };
  }

  // Create a Comment object from a Map
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      uid: map['uid'],
      postId: map['postId'],
      commentId: map['commentId'],
      commentText: map['commentText'],
      profilePic: map['profilePic'],
      userName: map['userName'],
      time: DateTime.parse(map['time']),
      likes: List<String>.from(map['likes']),
    );
  }
}
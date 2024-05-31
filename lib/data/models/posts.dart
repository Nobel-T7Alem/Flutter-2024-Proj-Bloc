import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    required this.name,
    required this.description,
    required this.contact,
    required this.user,
  }) ;
  String? id;
  String name;
  String description;
  String contact;
  String user;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    contact: json["contact"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "contact": contact,
    "user": user,
  };
}
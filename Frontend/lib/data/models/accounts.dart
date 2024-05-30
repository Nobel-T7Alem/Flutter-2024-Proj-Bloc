import 'dart:convert';

List<Account> accountFromJson(String str) => List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.email,
    this.password

  }) ;
  String name;
  String username;
  String role;
  String id;
  String email;
  String? password;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    name: json["name"],
    username: json["username"],
    role: json["role"],
    id: json["_id"],
    email: json["email"],
    password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "role": role,
    "_id": id,
    "email": email,
    "password": password
  };
}
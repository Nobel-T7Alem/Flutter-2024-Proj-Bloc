import 'dart:convert';

import '../models/posts.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.10:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<int?> addPost(post) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.10:3000/posts');
    final response = await client.post(uri,
        headers: {'Content-Type': 'application/json'}, body: json.encode(post));
      return response.statusCode;
  }
}

Future<String?> signUp(String fullName, String email, String username,
    String password, String role) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.10:3000/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': fullName,
      "username": username,
      'email': email,
      'password': password,
      'role': role,
    }),
  );
  if (response.statusCode == 201) {
    print("success");
    return null;
  } else {
    print(response.statusCode);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    return responseBody['message'] ?? 'Failed to sign up';
  }
}

import 'dart:convert';

import '../models/posts.dart';
import 'package:http/http.dart' as http;
class RemoteService
{

  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.7:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null
      );
    }
  }
}


Future<String?> signUp(String fullName, String email, String username, String password) async {
  print(fullName);
  print(email);
  print(username);
  print(password);

  final response = await http.post(
    Uri.parse('http://192.168.4.138:3000/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': fullName,
      "username": username,
      'email': email,
      'password': password,
      'role': "user"
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/calendars.dart';
import '../models/posts.dart';
import 'package:http/http.dart' as http;

class SharedPreferenceService {
  Future writeCache({
    required String key,
    required String value,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isSaved = await pref.setString(key, value);
    debugPrint(isSaved.toString());
  }

  Future readCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    if (value != null) {
      return value.toString();
    } else {
      return null;
    }
  }
}

class RemoteService {
  Future<int?> addPost(post) async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? token = await sharedPrefService.readCache(key: "token");
    if (token == null) {
      return 401;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.2:3000/posts');
    final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: post);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody);
    return response.statusCode;
  }

  Future<String?> signUp(String fullName, String email, String username,
      String password, String role) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.2:3000/auth/signup'),
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
      SharedPreferenceService sharedPrefService = SharedPreferenceService();
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      sharedPrefService.writeCache(key: "token", value: responseBody['token']);
      sharedPrefService.writeCache(key: "uId", value: responseBody['userId']);
      return null;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to sign up';
    }
  }

  Future<List<Post>?> getMyPosts() async {
    var client = http.Client();
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? userId = await sharedPrefService.readCache(key: "uId");
    if (userId == null) {
      return null;
    }
    String url = 'http://192.168.1.2:3000/posts/$userId';
    var uri = Uri.parse(url);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<String?>? addToCalendar(String date, String id) async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? userId = await sharedPrefService.readCache(key: "uId");
    String? token = await sharedPrefService.readCache(key: "token");
    if (userId == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.2:3000/calendars/add/$id');
    final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'date': date,
          'user': userId,
        }));
    if (response.statusCode == 201) {
      return "Post Created";
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to add to calendar';
    }
  }

  Future<List<Calendar>?> getCalendar() async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? token = await sharedPrefService.readCache(key: "token");
    if (token == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.2:3000/calendars/mycalendar');
    final response =
        await client.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(calendarFromJson(jsonString));
      return calendarFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<Post?> getPost(String id) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.2:3000/posts/$id');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString)[0];
    } else {
      return (null);
    }
  }

  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.2:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<String?> logIn(String username, String password) async {
    var client = http.Client();
    final uri = Uri(
      scheme: 'http',
      host: '192.168.1.2',
      port: 3000,
      path: '/auth/login',
      queryParameters: {
        'username': username,
        'password': password,
      },
    );
    final url = uri.toString();
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      SharedPreferenceService sharedPrefService = SharedPreferenceService();
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      sharedPrefService.writeCache(key: "token", value: responseBody['token']);
      sharedPrefService.writeCache(key: "uId", value: responseBody['userId']);
      if (responseBody['status'] == "user") {
        return "user";
      } else if (responseBody['status'] == "agency") {
        return "agency";
      }
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to log in';
    }
    return null;
  }
}

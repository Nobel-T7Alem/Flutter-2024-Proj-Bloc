import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/accounts.dart';
import '../models/calendars.dart';
import '../models/posts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
    var uri = Uri.parse('http://192.168.38.24:3000/posts');
    final response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: post);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    return response.statusCode;
  }

  Future<String?> signUp(String fullName, String email, String username,
      String password, String role) async {
    final response = await http.post(
      Uri.parse('http://192.168.38.24:3000/auth/signup'),
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
    String url = 'http://192.168.38.24:3000/posts/myposts/$userId';
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
    var uri = Uri.parse('http://192.168.38.24:3000/calendars/add/$id');
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

    final client = http.Client();
    try {
      var calendarUri =
          Uri.parse('http://192.168.38.24:3000/calendars/mycalendar');
      final calendarResponse = await client.get(
        calendarUri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (calendarResponse.statusCode == 200) {
        var calendarData = json.decode(calendarResponse.body) as List;
        List<Calendar> posts = [];
        for (var item in calendarData) {
          var postId = item["post"];
          var postUri = Uri.parse('http://192.168.38.24:3000/posts/$postId');
          final postResponse = await client.get(
            postUri,
            headers: {'Authorization': 'Bearer $token'},
          );
          DateTime dateTime = DateTime.parse(item["date"].toString());
          DateFormat formatter = DateFormat('yyyy-MM-dd');
          String formatted = formatter.format(dateTime);
          if (postResponse.statusCode == 200) {
            var postData = Post.fromJson(jsonDecode(postResponse.body));
            posts.add(Calendar(
                id: postData.id,
                name: postData.name,
                description: postData.description,
                contact: postData.contact,
                date: formatted));
          }
        }
        return posts;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Post?> getPost(String id) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/posts/$id');
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
    var uri = Uri.parse('http://192.168.38.24:3000/posts');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return (null);
    }
  }

  Future<List<Account>?> getAccounts() async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? role = await sharedPrefService.readCache(key: "role");
    String? token = await sharedPrefService.readCache(key: "token");
    if (role == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/user');
    final response = await client.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return accountFromJson(jsonString);
    } else {
      return null;
    }
  }

  Future<int> updateProfile(Map<String, String?> post) async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? token = await sharedPrefService.readCache(key: "token");
    String? userId = await sharedPrefService.readCache(key: "uId");
    if (token == null) {
      return 401;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/user/$userId/profile');

    // Create a map to hold only the fields that are not null
    Map<String, String> body = {};
    if (post['name'] != null) body['name'] = post['name']!;
    if (post['email'] != null) body['email'] = post['email']!;
    if (post['username'] != null) body['username'] = post['username']!;
    if (post['password'] != null) body['password'] = post['password']!;

    final response = await client.patch(
      uri,
      headers: {
        'Content-Type': 'application/json', // corrected Content-Type
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    return response.statusCode;
  }

  Future<int> changeRole(id) async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? token = await sharedPrefService.readCache(key: "token");
    if (token == null) {
      return 401;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/user/$id/role');
    final response = await client.patch(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'role': 'agency',
        }));
    return response.statusCode;
  }

  Future<int?> deleteProfile() async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? userId = await sharedPrefService.readCache(key: "uId");
    String? token = await sharedPrefService.readCache(key: "token");
    if (userId == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/user/$userId/account');
    final response = await client.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return null;
  }

  Future<int?> deleteAccount(id) async {
    SharedPreferenceService sharedPrefService = SharedPreferenceService();
    String? role = await sharedPrefService.readCache(key: "role");
    String? token = await sharedPrefService.readCache(key: "token");
    if (role == null) {
      return null;
    }
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/user/$id');
    final response = await client.delete(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode;
  }

  Future<int> editPost(id, post) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/posts/$id');
    final response = await client.put(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': post.name,
          'description': post.description,
          'contact': post.contact,
        }));
    return response.statusCode;
  }

  Future<int> deletePost(id) async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.38.24:3000/posts/$id');
    final response = await client.delete(uri);
    return response.statusCode;
  }

  Future<String?> logIn(String username, String password) async {
    var client = http.Client();
    var link = Uri(
      scheme: 'http',
      host: '192.168.38.24',
      port: 3000,
      path: '/auth/login',
      queryParameters: {
        'username': username,
        'password': password,
      },
    );
    var response = await client.get(link);
    if (response.statusCode == 200) {
      SharedPreferenceService sharedPrefService = SharedPreferenceService();
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      sharedPrefService.writeCache(key: "token", value: responseBody['token']);
      sharedPrefService.writeCache(key: "uId", value: responseBody['userId']);
      if (responseBody['status'] == "user") {
        return "user";
      } else if (responseBody['status'] == "agency") {
        return "agency";
      } else if (responseBody['status'] == "admin") {
        sharedPrefService.writeCache(key: "role", value: "admin");
        return "admin";
      }
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['message'] ?? 'Failed to log in';
    }
    return null;
  }
}

import 'dart:convert';

import 'package:buzzoole/data/models/auth.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  Future<Auth> fetchBearerToken() async {
    final response = await http
        .post('https://api.themoviedb.org/4/auth/request_token', headers: {
      'Content-Type': 'application/json;charset=utf-8',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwM2IyYTJjYzljMDZiNzQyMjc5NWFmMWJjNDMwMzAzMCIsInN1YiI6IjVhNWU0YmQ5MGUwYTI2MWE2ODAwMjUwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W-u21yLA5SDZPWzpIgoHfzGPDHyCfum9ECXSOpTJKvk'
    });
    Auth _auth;
    if (response.statusCode == 200) {
      _auth = Auth.fromJson(jsonDecode(response.body));
    }
    return _auth;
  }
}

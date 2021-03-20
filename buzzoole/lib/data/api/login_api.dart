import 'dart:convert';

import 'package:buzzoole/data/models/request_token.dart';
import 'package:buzzoole/data/models/session.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  Future<RequestToken> fetchRequestToken() async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/authentication/token/new?api_key=${BuzzooleStrings().apiKey}');
    RequestToken _requestToken;
    if (response.statusCode == 200) {
      _requestToken = RequestToken.fromJson(jsonDecode(response.body));
      BuzzooleStrings().requestToken = _requestToken.requestToken;
    }
    return _requestToken;
  }

  Future<RequestToken> sendLoginData(String username, String password) async {
    final response = await http.post(
        '${BuzzooleStrings().baseURL}/authentication/token/validate_with_login?api_key=${BuzzooleStrings().apiKey}',
        body: {
          'username': username,
          'password': password,
          'request_token': BuzzooleStrings().requestToken
        });
    RequestToken _requestToken;
    if (response.statusCode == 200) {
      _requestToken = RequestToken.fromJson(jsonDecode(response.body));
    }
    return _requestToken;
  }

  Future<Session> fetchSession() async {
    final response = await http.post(
        '${BuzzooleStrings().baseURL}/authentication/session/new?api_key=${BuzzooleStrings().apiKey}',
        body: {'request_token': BuzzooleStrings().requestToken});
    Session _session;
    if (response.statusCode == 200) {
      _session = Session.fromJson(jsonDecode(response.body));
    }
    return _session;
  }
}

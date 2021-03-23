import 'dart:convert';

import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/data/models/auth.dart';
import 'package:buzzoole/data/models/request_token.dart';
import 'package:buzzoole/data/models/session.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:buzzoole/utils/utils.dart';
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

  Future<Auth> sendLoginData(String username, String password) async {
    final _tokenResponse = await http.get(
        '${BuzzooleStrings().baseURL}/authentication/token/new?api_key=${BuzzooleStrings().apiKey}');
    RequestToken _requestToken;
    if (_tokenResponse.statusCode == 200) {
      _requestToken = RequestToken.fromJson(jsonDecode(_tokenResponse.body));
      BuzzooleStrings().requestToken = _requestToken.requestToken;
      BuzzooleUtils().setUsernameInSharedPreferences(username);
    }
    final _loginResponse = await http.post(
        '${BuzzooleStrings().baseURL}/authentication/token/validate_with_login?api_key=${BuzzooleStrings().apiKey}',
        body: {
          'username': username,
          'password': password,
          'request_token': BuzzooleStrings().requestToken
        });

    Auth _auth;

    if (_loginResponse.statusCode == 200) {
      _auth = Auth.fromJson(jsonDecode(_loginResponse.body));
    }
    return _auth;
  }

  Future<Session> fetchSession() async {
    final response = await http.post(
        '${BuzzooleStrings().baseURL}/authentication/session/new?api_key=${BuzzooleStrings().apiKey}',
        body: {'request_token': BuzzooleStrings().requestToken});
    Session _session;
    if (response.statusCode == 200) {
      _session = Session.fromJson(jsonDecode(response.body));
      BuzzooleUtils().setSessionIdInSharedPreferences(_session.sessionId);
    }

    final _accountResponse = await http.get(
      '${BuzzooleStrings().baseURL}/account?api_key=${BuzzooleStrings().apiKey}&session_id=${_session.sessionId}',
    );

    if (_accountResponse.statusCode == 200) {
      Account _account = Account.fromJson(jsonDecode(_accountResponse.body));
      BuzzooleUtils().setAccountIdInSharedPreferences(_account.id);
    }

    return _session;
  }
}

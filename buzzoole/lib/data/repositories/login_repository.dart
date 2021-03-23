import 'package:buzzoole/data/api/login_api.dart';
import 'package:buzzoole/data/models/auth.dart';
import 'package:buzzoole/data/models/request_token.dart';
import 'package:buzzoole/data/models/session.dart';

class LoginRepository {
  LoginAPI _loginAPI = LoginAPI();

  Future<RequestToken> fetchRequestToken() async {
    return _loginAPI.fetchRequestToken();
  }

  Future<Auth> sendLoginData(String username, String password) async {
    return _loginAPI.sendLoginData(username, password);
  }

  Future<Session> fetchSession() async {
    return _loginAPI.fetchSession();
  }
}

import 'package:buzzoole/data/api/login_api.dart';
import 'package:buzzoole/data/models/auth.dart';
import 'package:buzzoole/data/models/request_token.dart';

class LoginRepository {
  LoginAPI _loginAPI = LoginAPI();

  Future<RequestToken> fetchRequestToken() async {
    return _loginAPI.fetchRequestToken();
  }
}

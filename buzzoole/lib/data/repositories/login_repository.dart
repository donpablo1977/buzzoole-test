import 'package:buzzoole/data/api/login_api.dart';
import 'package:buzzoole/data/models/auth.dart';

class LoginRepository {
  LoginAPI _loginAPI = LoginAPI();

  Future<Auth> fetchBearerToken() async {
    return _loginAPI.fetchBearerToken();
  }
}

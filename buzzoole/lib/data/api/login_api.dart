import 'dart:convert';

import 'package:buzzoole/data/models/request_token.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  Future<RequestToken> fetchRequestToken() async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/authentication/token/new?api_key=${BuzzooleStrings().apiKey}');
    RequestToken _requestToken;
    if (response.statusCode == 200) {
      _requestToken = RequestToken.fromJson(jsonDecode(response.body));
    }
    return _requestToken;
  }
}

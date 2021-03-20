import 'dart:convert';

import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/utils/strings.dart';
import 'package:http/http.dart' as http;

class AccountAPI {
  Future<Account> fetchAccountDetails() async {
    final response = await http.get(
        '${BuzzooleStrings().baseURL}/account?api_key=${BuzzooleStrings().apiKey}&session_id=${BuzzooleStrings().sessionId}');
    Account _account;
    if (response.statusCode == 200) {
      _account = Account.fromJson(jsonDecode(response.body));
    }
    return _account;
  }
}

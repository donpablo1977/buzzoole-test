import 'package:buzzoole/data/api/account_api.dart';
import 'package:buzzoole/data/models/account.dart';

class AccountRepository {
  AccountAPI _accountAPI = AccountAPI();

  Future<Account> fetchAccountDetails() async {
    return _accountAPI.fetchAccountDetails();
  }
}

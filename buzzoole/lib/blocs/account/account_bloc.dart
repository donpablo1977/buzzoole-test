import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buzzoole/data/models/account.dart';
import 'package:buzzoole/data/repositories/account_repository.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc(this.accountRepository) : super(AccountInitial());

  @override
  void onTransition(Transition<AccountEvent, AccountState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    yield FetchingState();
    try {
      Account _account = await accountRepository.fetchAccountDetails();
      if (_account != null) {
        print(_account.username);
        yield FetchedState();
      }
    } catch (e) {
      yield FailedState();
    }
  }
}

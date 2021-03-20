part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class FetchingState extends AccountState {}

class FetchedState extends AccountState {}

class FailedState extends AccountState {}

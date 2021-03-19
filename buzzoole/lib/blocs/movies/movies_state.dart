part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class FetchingState extends MoviesState {}

class FetchedState extends MoviesState {}

class FailedState extends MoviesState {}

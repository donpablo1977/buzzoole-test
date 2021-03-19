part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class FetchingEvent extends MoviesEvent {}

class FetchedEvent extends MoviesEvent {}

class FailedEvent extends MoviesEvent {}

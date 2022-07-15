part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailMoviesLoading extends DetailMovieState {}

class DetailMoviesEmpty extends DetailMovieState {}

class DetailMoviesLoaded extends DetailMovieState {
  final MovieDetail result;

  const DetailMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class DetailMoviesError extends DetailMovieState {
  final String message;

  const DetailMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

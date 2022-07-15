part of 'recommend_movies_bloc.dart';

abstract class RecommendMoviesState extends Equatable {
  const RecommendMoviesState();

  @override
  List<Object> get props => [];
}

class RecommendMoviesEmpty extends RecommendMoviesState {}

class RecommendMoviesLoading extends RecommendMoviesState {}

class RecommendMoviesLoaded extends RecommendMoviesState {
  final List<Movie> result;

  const RecommendMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendMoviesError extends RecommendMoviesState {
  final String message;

  const RecommendMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

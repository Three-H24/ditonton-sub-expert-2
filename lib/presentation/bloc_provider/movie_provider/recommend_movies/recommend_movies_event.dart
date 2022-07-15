part of 'recommend_movies_bloc.dart';

abstract class RecommendMoviesEvent extends Equatable {
  const RecommendMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationMovies extends RecommendMoviesEvent {
  final int id;

  const FetchRecommendationMovies(this.id);

  @override
  List<Object> get props => [id];
}

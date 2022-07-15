import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommend_movies_event.dart';
part 'recommend_movies_state.dart';

class RecommendMoviesBloc
    extends Bloc<RecommendMoviesEvent, RecommendMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendMoviesBloc(this.getMovieRecommendations)
      : super(RecommendMoviesEmpty()) {
    on<FetchRecommendationMovies>((event, emit) async {
      emit(RecommendMoviesLoading());
      final result = await getMovieRecommendations.execute(event.id);

      result.fold((failure) => emit(RecommendMoviesError(failure.message)),
          (success) => emit(RecommendMoviesLoaded(success)));
    });
  }
}

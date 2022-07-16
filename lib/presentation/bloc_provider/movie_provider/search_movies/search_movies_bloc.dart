import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc(this.searchMovies) : super(SearchMoviesEmpty()) {
    on<SearchMovieIsEmpty>((event, emit) => emit(SearchMoviesEmpty()));
    on<OnSearchMoviesEvent>((event, emit) async {
      emit(SearchMoviesLoading());

      final result = await searchMovies.execute(event.query);

      result.fold((failure) => emit(SearchMoviesError(failure.message)),
          (success) => emit(SearchMoviesLoaded(success)));
    });
  }
}

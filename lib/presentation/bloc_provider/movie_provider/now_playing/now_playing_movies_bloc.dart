import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchAllNowPlayingMoviesEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingMoviesError(failure.message));
      }, (success) {
        emit(NowPlayingMoviesLoaded(success));
      });
    });
  }
}

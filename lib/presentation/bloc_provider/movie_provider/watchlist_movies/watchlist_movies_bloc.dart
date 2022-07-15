import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';

part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistMoviesBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMoviesEmpty()) {
    on<FetchWatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) => emit(WatchlistMoviesError(failure.message)),
          (success) => emit(WatchlistMoviesLoaded(success)));
    });

    on<FetchStatusMoviesEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);

      emit(WatchlistStatussMovieLoaded(result));
    });

    on<AddToWatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());

      final result = await saveWatchlist.execute(event.result);

      result.fold((failure) => emit(WatchlistMoviesError(failure.message)),
          (success) => emit(AddToWatchlistMoviesSuccess(success)));
    });

    on<RemoveFromWatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());

      final result = await removeWatchlist.execute(event.result);

      result.fold((failure) => emit(WatchlistMoviesError(failure.message)),
          (success) => emit(AddToWatchlistMoviesSuccess(success)));
    });
  }
}

part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchWatchlistMoviesEvent extends WatchlistMoviesEvent {}

class FetchStatusMoviesEvent extends WatchlistMoviesEvent {
  final int id;

  const FetchStatusMoviesEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlistMoviesEvent extends WatchlistMoviesEvent {
  final MovieDetail result;

  const AddToWatchlistMoviesEvent(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveFromWatchlistMoviesEvent extends WatchlistMoviesEvent {
  final MovieDetail result;

  const RemoveFromWatchlistMoviesEvent(this.result);

  @override
  List<Object> get props => [result];
}
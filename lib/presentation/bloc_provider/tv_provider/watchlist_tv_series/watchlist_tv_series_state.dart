part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoaded extends WatchlistTvSeriesState {
  final List<Tv> result;

  const WatchlistTvSeriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvSeriesStatusSuccess extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesErorr extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesErorr(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesStatusLoaded extends WatchlistTvSeriesState {
  final bool result;

  const WatchlistTvSeriesStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}

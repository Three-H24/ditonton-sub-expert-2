part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {}

class FetchStatusWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  final int id;

  const FetchStatusWatchlistTvSeriesEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  final TvDetail result;

  const AddWatchlistTvSeriesEvent(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchlistTvSeriesEvent extends WatchlistTvSeriesEvent {
  final TvDetail result;

  const RemoveWatchlistTvSeriesEvent(this.result);

  @override
  List<Object> get props => [result];
}

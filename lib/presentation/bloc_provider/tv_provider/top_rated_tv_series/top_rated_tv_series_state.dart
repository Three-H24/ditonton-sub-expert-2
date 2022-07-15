part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoaded extends TopRatedTvSeriesState {
  final List<Tv> result;

  const TopRatedTvSeriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

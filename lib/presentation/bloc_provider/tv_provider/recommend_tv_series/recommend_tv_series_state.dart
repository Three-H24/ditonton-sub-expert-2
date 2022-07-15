part of 'recommend_tv_series_bloc.dart';

abstract class RecommendTvSeriesState extends Equatable {
  const RecommendTvSeriesState();

  @override
  List<Object> get props => [];
}

class RecommendTvSeriesEmpty extends RecommendTvSeriesState {}

class RecommendTvSeriesLoading extends RecommendTvSeriesState {}

class RecommendTvSeriesLoaded extends RecommendTvSeriesState {
  final List<Tv> result;

  const RecommendTvSeriesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendTvSeriesError extends RecommendTvSeriesState {
  final String message;

  const RecommendTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

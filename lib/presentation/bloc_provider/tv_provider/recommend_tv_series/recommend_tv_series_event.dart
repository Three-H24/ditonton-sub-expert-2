part of 'recommend_tv_series_bloc.dart';

abstract class RecommendTvSeriesEvent extends Equatable {
  const RecommendTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendTvSeriesEvent extends RecommendTvSeriesEvent {
  final int id;

  const FetchRecommendTvSeriesEvent(this.id);

  @override
  List<Object> get props => [id];
}

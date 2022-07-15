part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnSearchTvSeriesEvent extends SearchTvSeriesEvent {
  final String querySearch;

  const OnSearchTvSeriesEvent(this.querySearch);

  @override
  List<Object> get props => [querySearch];
}

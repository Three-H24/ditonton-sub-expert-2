import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/search_tv.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_series_event.dart';

part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTv searchTv;

  SearchTvSeriesBloc(this.searchTv) : super(SearchTvSeriesEmpty()) {
    on<OnSearchTvSeriesEvent>((event, emit) async {
      emit(SearchTvSeriesLoading());

      final result = await searchTv.execute(event.querySearch);

      result.fold((failure) => emit(SearchTvSeriesError(failure.message)),
          (success) => emit(SearchTvSeriesLoaded(success)));
    });
  }
}

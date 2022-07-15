import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_popular.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetTvPopular getTvPopular;

  PopularTvSeriesBloc(this.getTvPopular) : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeriesEvent>((event, emit) async {
      emit(PopularTvSeriesLoading());

      final result = await getTvPopular.execute();

      result.fold((failure) => emit(PopularTvSeriesError(failure.message)),
          (success) => emit(PopularTvSeriesLoaded(success)));
    });
  }
}

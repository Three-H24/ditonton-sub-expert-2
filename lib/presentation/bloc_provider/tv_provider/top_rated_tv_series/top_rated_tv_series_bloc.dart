import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvSeriesBloc(this.getTopRatedTv) : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedTvSeriesEvent>((event, emit) async {
      emit(TopRatedTvSeriesLoading());

      final result = await getTopRatedTv.execute();

      result.fold((failure) => emit(TopRatedTvSeriesError(failure.message)),
          (success) => emit(TopRatedTvSeriesLoaded(success)));
    });
  }
}

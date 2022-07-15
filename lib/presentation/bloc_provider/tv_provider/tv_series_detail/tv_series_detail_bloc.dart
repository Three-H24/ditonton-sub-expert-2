import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvDetail getTvDetail;

  TvSeriesDetailBloc(this.getTvDetail) : super(TvSeriesDetailEmpty()) {
    on<FetchTvSeriesDetailEvent>((event, emit) async {
      emit(TvSeriesDetailLoading());

      final result = await getTvDetail.execute(event.id);

      result.fold((failure) => emit(TvSeriesDetailError(failure.message)),
          (success) => emit(TvSeriesDetailLoaded(success)));
    });
  }
}

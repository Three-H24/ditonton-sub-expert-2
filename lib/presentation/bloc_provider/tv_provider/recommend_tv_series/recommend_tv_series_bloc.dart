import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommend_tv_series_event.dart';

part 'recommend_tv_series_state.dart';

class RecommendTvSeriesBloc
    extends Bloc<RecommendTvSeriesEvent, RecommendTvSeriesState> {
  final GetTvRecommendations getTvRecommendations;

  RecommendTvSeriesBloc(this.getTvRecommendations)
      : super(RecommendTvSeriesEmpty()) {
    on<FetchRecommendTvSeriesEvent>((event, emit) async {
      emit(RecommendTvSeriesLoading());

      final result = await getTvRecommendations.execute(event.id);

      result.fold((failure) => emit(RecommendTvSeriesError(failure.message)),
          (success) => emit(RecommendTvSeriesLoaded(success)));
    });
  }
}

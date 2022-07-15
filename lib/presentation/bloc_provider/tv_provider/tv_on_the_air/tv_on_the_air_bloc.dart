import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:equatable/equatable.dart';

part 'tv_on_the_air_event.dart';

part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetTvOnTheAir getTvOnTheAir;

  TvOnTheAirBloc(this.getTvOnTheAir) : super(TvOnTheAirEmpty()) {
    on<FetchAllTvOnTheAirEvent>((event, emit) async {
      emit(TvOnTheAirLoading());

      final result = await getTvOnTheAir.execute();

      result.fold((failure) => emit(TvOnTheAirError(failure.message)),
          (success) => emit(TvOnTheAirLoaded(success)));
    });
  }
}

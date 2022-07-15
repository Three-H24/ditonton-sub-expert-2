import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListTv getWatchListTv;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchListTv removeWatchListTv;

  WatchlistTvSeriesBloc({
    required this.getWatchListTv,
    required this.getWatchListStatusTv,
    required this.saveWatchListTv,
    required this.removeWatchListTv,
  }) : super(WatchlistTvSeriesEmpty()) {
    on<FetchWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await getWatchListTv.execute();

      result.fold((failure) => emit(WatchlistTvSeriesErorr(failure.message)),
          (success) => emit(WatchlistTvSeriesLoaded(success)));
    });

    on<FetchStatusWatchlistTvSeriesEvent>((event, emit) async {
      final result = await getWatchListStatusTv.execute(event.id);

      emit(WatchlistTvSeriesStatusLoaded(result));
    });

    on<AddWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await saveWatchListTv.execute(event.result);

      result.fold((failure) => emit(WatchlistTvSeriesErorr(failure.message)),
          (success) => emit(WatchlistTvSeriesStatusSuccess(success)));
    });

    on<RemoveWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await removeWatchListTv.execute(event.result);

      result.fold((failure) => emit(WatchlistTvSeriesErorr(failure.message)),
          (success) => emit(WatchlistTvSeriesStatusSuccess(success)));
    });
  }
}

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/tv_entities/tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchListTv removeWatchListTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatusTv,
    required this.saveWatchListTv,
    required this.removeWatchListTv,
  });

  late TvDetail _tvDetail;

  TvDetail get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.Empty;

  RequestState get tvState => _tvState;

  List<Tv> _listTvRecommendations = [];

  List<Tv> get listTvRecommendations => _listTvRecommendations;

  RequestState _tvRecommendationsState = RequestState.Empty;

  RequestState get tvRecommendationsState => _tvRecommendationsState;

  String _message = '';

  String get message => _message;

  bool _isAddedToWatchListTv = false;

  bool get isAddedToWatchListTv => _isAddedToWatchListTv;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailTvResult = await getTvDetail.execute(id);
    final recommendationTvResult = await getTvRecommendations.execute(id);
    detailTvResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _tvRecommendationsState = RequestState.Loading;
        _tvDetail = tv;
        notifyListeners();
        recommendationTvResult.fold(
          (failure) {
            _tvRecommendationsState = RequestState.Error;
            _message = failure.message;
          },
          (tvs) {
            _tvRecommendationsState = RequestState.Loaded;
            _listTvRecommendations = tvs;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistTvMessage = '';

  String get watchlistTvMessage => _watchlistTvMessage;

  Future<void> addWatchlistTv(TvDetail tv) async {
    final result = await saveWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistTvMessage = failure.message;
      },
      (successMessage) async {
        _watchlistTvMessage = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvDetail tv) async {
    final result = await removeWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistTvMessage = failure.message;
      },
      (successMessage) async {
        _watchlistTvMessage = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _isAddedToWatchListTv = result;
    notifyListeners();
  }
}

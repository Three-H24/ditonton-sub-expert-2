import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_popular.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _tvOnTheAir = <Tv>[];

  List<Tv> get tvOnTheAir => _tvOnTheAir;

  RequestState _tvOnTheAirState = RequestState.Empty;

  RequestState get tvOnTheAirState => _tvOnTheAirState;

  var _popularTv = <Tv>[];

  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;

  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];

  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;

  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';

  String get message => _message;

  TvListNotifier({
    required this.getTvOnTheAir,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetTvOnTheAir getTvOnTheAir;
  final GetTvPopular getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchTvOnTheAir() async {
    _tvOnTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _tvOnTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _tvOnTheAirState = RequestState.Loaded;
        _tvOnTheAir = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}

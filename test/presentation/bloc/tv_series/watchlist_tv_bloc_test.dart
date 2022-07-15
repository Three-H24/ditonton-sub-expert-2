import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  WatchlistTvSeriesBloc,
  GetWatchListTv,
  GetWatchListStatusTv,
  SaveWatchListTv,
  RemoveWatchListTv,
])
void main() {
  late MockGetWatchListTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchListTv mockSaveWatchlistTv;
  late MockRemoveWatchListTv mockRemoveWatchlistTv;
  late WatchlistTvSeriesBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchListTv();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchListTv();
    mockRemoveWatchlistTv = MockRemoveWatchListTv();
    watchlistTvBloc = WatchlistTvSeriesBloc(
      getWatchListTv: mockGetWatchlistTv,
      getWatchListStatusTv: mockGetWatchListStatusTv,
      saveWatchListTv: mockSaveWatchlistTv,
      removeWatchListTv: mockRemoveWatchlistTv,
    );
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(watchlistTvBloc.state, WatchlistTvSeriesEmpty());
  });

  group('Watchlist Tv Series Test', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => Right(testWatchlistTvSeries),
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeriesEvent()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesLoaded(testWatchlistTvSeries),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (Loading, Error) when get watchlist is unsuccessful',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeriesEvent()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesErorr('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (Loaded) when get status TV watchlist is successful',
      build: () {
        when(mockGetWatchListStatusTv.execute(tvId)).thenAnswer(
          (_) async => true,
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchStatusWatchlistTvSeriesEvent(tvId)),
      expect: () => [WatchlistTvSeriesStatusLoaded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTv.execute(tvId));
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (success) when add to watchlist is successful',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right("Success"));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTvSeriesEvent(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesStatusSuccess("Success"),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (success) when remove from watchlist is successful',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right("Removed"),
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesStatusSuccess("Removed"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (error) when add to watchlist is unsuccessful',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed')),
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTvSeriesEvent(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesErorr("Failed"),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit (error) when remove from watchlist is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed')),
        );
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTvSeriesEvent(testTvSeriesDetail)),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesErorr("Failed"),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
      },
    );
  });
}

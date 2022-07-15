import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  WatchlistMoviesBloc,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistMoviesBloc migrateMovieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    migrateMovieWatchlistBloc = WatchlistMoviesBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const movieId = 1;

  test("initial state should be empty", () {
    expect(migrateMovieWatchlistBloc.state, WatchlistMoviesEmpty());
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (Loading, Loaded) when data is successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Right(testWatchlistMoviesList),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMoviesEvent()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesLoaded(testWatchlistMoviesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (Loading, Error) when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Left(ServerFailure("Can't get data")),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMoviesEvent()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (Loaded) when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(movieId)).thenAnswer(
        (_) async => true,
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchStatusMoviesEvent(movieId)),
    expect: () => [WatchlistStatussMovieLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(movieId));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (success) when add movie item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => const Right("Success"),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlistMoviesEvent(testMovieDetail)),
    expect: () => [
      WatchlistMoviesLoading(),
      AddToWatchlistMoviesSuccess("Success"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (success) when remove movie item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => const Right("Removed"),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlistMoviesEvent(testMovieDetail)),
    expect: () => [
      WatchlistMoviesLoading(),
      AddToWatchlistMoviesSuccess("Removed"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (error) when add movie item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => Left(DatabaseFailure('Failed')),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlistMoviesEvent(testMovieDetail)),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError("Failed"),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit (error) when remove movie item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => Left(DatabaseFailure('Failed')),
      );
      return migrateMovieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlistMoviesEvent(testMovieDetail)),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError("Failed"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}

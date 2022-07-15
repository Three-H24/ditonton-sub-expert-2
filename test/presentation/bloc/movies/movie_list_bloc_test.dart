import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/now_playing/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([NowPlayingMoviesBloc ,GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMoviesEmpty());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit (Loading, Error) when data is successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Right(testMovieList),
      );
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchAllNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit (Loading, Error) when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')),
      );
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchAllNowPlayingMoviesEvent()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
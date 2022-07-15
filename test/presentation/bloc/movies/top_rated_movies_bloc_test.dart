import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([TopRatedMoviesBloc ,GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc migrateMovieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    migrateMovieTopRatedBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(migrateMovieTopRatedBloc.state, TopRatedMoviesEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit (Loading, Loaded) when data is Loaded successfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
              (_) async => Right(movieList),
        );
        return migrateMovieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit (Loading, Error) when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return migrateMovieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}

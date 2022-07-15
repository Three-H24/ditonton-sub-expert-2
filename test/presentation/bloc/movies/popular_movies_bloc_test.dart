import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([PopularMoviesBloc, GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(popularMovieBloc.state, PopularMoviesEmpty());
  });

  group('Popular Movies BLoC Test', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit (loading, loaded) when data is loaded successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
              (_) async => Right(movieList),
        );
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit (loading, error) when data is failed to loaded',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
              (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}

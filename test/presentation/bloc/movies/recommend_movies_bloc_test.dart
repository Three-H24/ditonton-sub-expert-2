import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/recommend_movies/recommend_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommend_movies_bloc_test.mocks.dart';

@GenerateMocks([RecommendMoviesBloc, GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late RecommendMoviesBloc recommendationMovieBloc;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendMoviesBloc(mockGetMovieRecommendation);
  });

  test("initial state should be empty", () {
    expect(recommendationMovieBloc.state, RecommendMoviesEmpty());
  });

  const movieId = 1;
  final movieList = <Movie>[];

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(movieId)).thenAnswer(
            (_) async => Right(movieList),
      );
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationMovies(movieId)),
    expect: () => [
      RecommendMoviesLoading(),
      RecommendMoviesLoaded(movieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(movieId));
    },
  );

  group('Recommendation Movies BLoC Test', () {
    blocTest<RecommendMoviesBloc, RecommendMoviesState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetMovieRecommendation.execute(movieId)).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendationMovies(movieId)),
      expect: () => [
        RecommendMoviesLoading(),
        RecommendMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(movieId));
      },
    );
  });
}
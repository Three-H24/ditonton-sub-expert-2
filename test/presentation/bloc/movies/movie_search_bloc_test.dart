import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/search_movies/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc searchMovieBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMoviesBloc(mockSearchMovies);
  });

  const query = "originalTitle";
  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(searchMovieBloc.state, SearchMoviesEmpty());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit (Loading, Loaded) when data is successfully',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => Right(movieList),
      );
      return searchMovieBloc;
    },
    act: (bloc) => bloc.add(OnSearchMoviesEvent(query)),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesLoaded(movieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  group('Search Movies BLoC Test', () {
    blocTest<SearchMoviesBloc, SearchMoviesState>(
      'Should emit (Loading, Error) when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnSearchMoviesEvent(query)),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(query));
      },
    );
  });
}

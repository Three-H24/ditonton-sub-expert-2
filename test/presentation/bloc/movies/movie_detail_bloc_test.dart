import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/detail_movie/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  DetailMovieBloc,
  GetMovieDetail,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieBloc detailMovieBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  const tId = 1;

  test("initial state should be empty", () {
    expect(detailMovieBloc.state, DetailMoviesEmpty());
  });

  group('Get Movie Detail', () {
    blocTest<DetailMovieBloc, DetailMovieState>(
        'should change movie when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Right(testMovieDetail),
          );
          return detailMovieBloc;
        },
        act: (detailMovieBloc) =>
            detailMovieBloc.add(FetchDetailsMovieEvent(tId)),
        expect: () => [
              DetailMoviesLoading(),
              DetailMoviesLoaded(testMovieDetail),
            ],
        verify: (detailMovieBloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
    blocTest<DetailMovieBloc, DetailMovieState>(
      'Should emit (Loading, Error) when get detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(FetchDetailsMovieEvent(tId)),
      expect: () => [
        DetailMoviesLoading(),
        const DetailMoviesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });
}

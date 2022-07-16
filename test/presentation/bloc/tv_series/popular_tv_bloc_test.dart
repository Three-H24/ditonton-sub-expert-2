import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_popular.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([PopularTvSeriesBloc, GetTvPopular])
void main() {
  late MockGetTvPopular mockGetPopularTv;
  late PopularTvSeriesBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetTvPopular();
    popularTvBloc = PopularTvSeriesBloc(mockGetPopularTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(popularTvBloc.state, PopularTvSeriesEmpty());
  });

  group('Popular TV BLoC Test', () {
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => Right(tvList),
        );
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeriesEvent()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit (Loading, Error) when get popular is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeriesEvent()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/recommend_tv_series/recommend_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommend_tv_series_bloc_test.mocks.dart';

@GenerateMocks([RecommendTvSeriesBloc, GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendations;
  late RecommendTvSeriesBloc migrateTvlsRecommendationBloc;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    migrateTvlsRecommendationBloc =
        RecommendTvSeriesBloc(mockGetTvRecommendations);
  });

  test("initial state should be empty", () {
    expect(migrateTvlsRecommendationBloc.state, RecommendTvSeriesEmpty());
  });

  const tvId = 1;
  final tvList = <Tv>[];

  group('Recommendation TV BLoC Test', () {
    blocTest<RecommendTvSeriesBloc, RecommendTvSeriesState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tvId)).thenAnswer(
          (_) async => Right(tvList),
        );
        return migrateTvlsRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendTvSeriesEvent(tvId)),
      expect: () => [
        RecommendTvSeriesLoading(),
        RecommendTvSeriesLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tvId));
      },
    );

    blocTest<RecommendTvSeriesBloc, RecommendTvSeriesState>(
      'Should emit (Loading, Error) when get recommendation is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tvId)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return migrateTvlsRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendTvSeriesEvent(tvId)),
      expect: () => [
        RecommendTvSeriesLoading(),
        RecommendTvSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tvId));
      },
    );
  });
}

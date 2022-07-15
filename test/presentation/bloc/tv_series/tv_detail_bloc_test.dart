import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  TvSeriesDetailBloc,
  GetTvDetail,
])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  group('Detail Movies BLoC Test', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tvId)).thenAnswer(
          (_) async => Right(testTvSeriesDetail),
        );
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetailEvent(tvId)),
      expect: () => [
        TvSeriesDetailLoading(),
        TvSeriesDetailLoaded(testTvSeriesDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tvId)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetailEvent(tvId)),
      expect: () => [
        TvSeriesDetailLoading(),
        TvSeriesDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );
  });
}

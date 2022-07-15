import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesBloc, GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvSeriesBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvSeriesBloc(mockGetTopRatedTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(topRatedTvBloc.state, TopRatedTvSeriesEmpty());
  });

  group('Top Rated TV BLoC Test', () {
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
              (_) async => Right(tvList),
        );
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeriesEvent()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit (Loading, Error) when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeriesEvent()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}

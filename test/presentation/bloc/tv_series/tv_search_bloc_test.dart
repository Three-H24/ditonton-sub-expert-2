import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/search_tv_series/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeriesBloc, SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late SearchTvSeriesBloc searchTvBloc;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvSeriesBloc(mockSearchTv);
  });

  const query = "originalTitle";
  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(searchTvBloc.state, SearchTvSeriesEmpty());
  });

  group('Search TV BLoC Test', () {
    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockSearchTv.execute(query)).thenAnswer(
          (_) async => Right(tvList),
        );
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnSearchTvSeriesEvent(query)),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(query));
      },
    );
    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'Should emit (Loading, Error) when get search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(query)).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnSearchTvSeriesEvent(query)),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(query));
      },
    );
  });
}

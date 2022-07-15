import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';



@GenerateMocks([
  TvOnTheAirBloc,
  GetTvOnTheAir,
])
void main() {
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late TvOnTheAirBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetTvOnTheAir);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvOnTheAirBloc.state, TvOnTheAirEmpty());
  });

  group('On Air TV BLoC Test', () {
    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'Should emit (Loading, Loaded) when data is successfully',
      build: () {
        when(mockGetTvOnTheAir.execute()).thenAnswer(
              (_) async => Right(tvList),
        );
        return tvOnTheAirBloc;
      },
      act: (bloc) => bloc.add(FetchAllTvOnTheAirEvent()),
      expect: () => [
        TvOnTheAirLoading(),
        TvOnTheAirLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockGetTvOnTheAir.execute());
      },
    );

    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'Should emit (Loading, Error) when get Tv On The Air is unsuccessful',
      build: () {
        when(mockGetTvOnTheAir.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvOnTheAirBloc;
      },
      act: (bloc) => bloc.add(FetchAllTvOnTheAirEvent()),
      expect: () => [
        TvOnTheAirLoading(),
        TvOnTheAirError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvOnTheAir.execute());
      },
    );
  });
}

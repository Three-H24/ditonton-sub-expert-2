import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late RemoveWatchListTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchListTv(mockTvRepository);
  });

  test('should remove watchlist TV from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlistTv(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist TV'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvRepository.removeWatchlistTv(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist TV'));
  });
}
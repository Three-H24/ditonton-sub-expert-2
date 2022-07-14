import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late SaveWatchListTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchListTv(mockTvRepository);
  });

  test('should save TV to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(testTvSeriesDetail)).thenAnswer(
      (_) async => Right('Added to Watchlist TV'),
    );
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvRepository.saveWatchlistTv(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist TV'));
  });
}

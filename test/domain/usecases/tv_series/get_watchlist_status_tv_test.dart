
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';


void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  test('should get watchlist status TV from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTv(1)).thenAnswer(
      (_) async => true,
    );
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(tvDatabaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist tv series', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockTvDatabaseHelper.insertWatchlistTv(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertWatchlistTv(testTvTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockTvDatabaseHelper.insertWatchlistTv(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlistTv(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist tv series', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockTvDatabaseHelper.removeWatchlistTv(testTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeWatchlistTv(testTvTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockTvDatabaseHelper.removeWatchlistTv(testTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlistTv(testTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get TV Detail By Id', () {
    final tId = 1;

    test('should return TV Detail Table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TV', () {
    test('should return list of TV Table from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
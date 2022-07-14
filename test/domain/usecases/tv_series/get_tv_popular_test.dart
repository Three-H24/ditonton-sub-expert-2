import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';


void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetTvPopular(mockTvRpository);
  });

  final tTv = <Tv>[];

  group('Get Popular TV Series tests', () {
    group('execute', () {
      test(
          'should get list of TV Series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTv()).thenAnswer(
          (_) async => Right(tTv),
        );
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}

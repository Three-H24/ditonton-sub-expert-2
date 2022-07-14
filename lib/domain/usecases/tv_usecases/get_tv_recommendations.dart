import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';
import '../../entities/tv_entities/tv.dart';

class GetTvRecommendations {
  final TvRepository tvRepository;

  GetTvRecommendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return tvRepository.getTvRecommendations(id);
  }
}
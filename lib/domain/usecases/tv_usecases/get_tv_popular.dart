import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvPopular {
  final TvRepository tvRepository;

  GetTvPopular(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getPopularTv();
  }
}
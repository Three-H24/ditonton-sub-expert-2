import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_entities/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository tvRepository;

  GetTopRatedTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getTopRatedTv();
  }
}
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

import '../../../common/failure.dart';
import '../../repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository tvRepository;

  GetTvDetail(this.tvRepository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return tvRepository.getTvDetail(id);
  }
}
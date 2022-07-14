import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

import '../../../common/failure.dart';
import '../../repositories/tv_repository.dart';

class RemoveWatchListTv {
  final TvRepository tvRepository;

  RemoveWatchListTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.removeWatchlistTv(tvDetail);
  }
}

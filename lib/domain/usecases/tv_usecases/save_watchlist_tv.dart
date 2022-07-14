import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';

import '../../../common/failure.dart';
import '../../repositories/tv_repository.dart';

class SaveWatchListTv {
  final TvRepository tvRepository;

  SaveWatchListTv(this.tvRepository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail) {
    return tvRepository.saveWatchlistTv(tvDetail);
  }
}

import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_entities/tv.dart';
import '../../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository tvRepository;

  SearchTv(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return tvRepository.searchTv(query);
  }
}

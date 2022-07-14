import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvOnTheAir {
  final TvRepository tvRepository;

  GetTvOnTheAir(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getTvOnTheAir();
  }
}
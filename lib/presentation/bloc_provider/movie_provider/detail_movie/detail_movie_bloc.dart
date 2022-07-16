import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieBloc(this.getMovieDetail) : super(DetailMoviesEmpty()) {
    on<FetchDetailsMovieEvent>((event, emit) async {
      emit(DetailMoviesLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold((failure) => emit(DetailMoviesError(failure.message)),
          (success) => emit(DetailMoviesLoaded(success)));
    });
  }
}

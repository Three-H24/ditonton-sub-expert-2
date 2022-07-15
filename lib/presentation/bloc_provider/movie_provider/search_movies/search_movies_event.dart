part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieIsEmpty extends SearchMoviesEvent {}

class OnSearchMoviesEvent extends SearchMoviesEvent {
  final String query;

  const OnSearchMoviesEvent(this.query);

  @override
  List<Object> get props {
    return [query];
  }
}

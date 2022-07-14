import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/local_data_source.dart';
import 'package:ditonton/data/datasources/tv/remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecases/search_tv.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider Movies
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // Provider Tv Series
  locator.registerFactory(
    () => TvListNotifier(
      getTvOnTheAir: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatusTv: locator(),
      saveWatchListTv: locator(),
      removeWatchListTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );

  // use case Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case Tv Series
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchListTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));

  // repository movies
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // repository tv series
  locator.registerFactory<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      tvLocalDataSource: locator(),
    ),
  );

  // data sources movies
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // data source tv series
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}

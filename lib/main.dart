import 'package:ditonton/common/constants.dart';
import 'package:ditonton/security/security_http_ssl_pinning.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/detail_movie/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/recommend_movies/recommend_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/search_movies/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/recommend_tv_series/recommend_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/search_tv_series/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/search_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie_pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/detail_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_pages/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SecurityHttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Movies BlocProviders
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMoviesBloc>()),

        // Tv Series Bloc
        BlocProvider(create: (_) => di.locator<TvOnTheAirBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesDetailBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<SearchTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesBloc>()),
      ],
      child: MaterialApp(
        title: 'Ditonton App Dicoding',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case DetailTvPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTvPage(id: id),
                settings: settings,
              );
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

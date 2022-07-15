import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/recommend_tv_series/recommend_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_pages/detail_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockDetailTvBloc extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class DetailTvEventFake extends Fake implements TvSeriesDetailEvent {}

class DetailTvStateFake extends Fake implements TvSeriesDetailState {}

class MockRecommendTvsBloc
    extends MockBloc<RecommendTvSeriesEvent, RecommendTvSeriesState>
    implements RecommendTvSeriesBloc {}

class RecommendationTvsEventFake extends Fake implements RecommendTvSeriesEvent {
}

class RecommendationTvsStateFake extends Fake implements RecommendTvSeriesState {
}

class MockWatchlistTvsBloc extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class WatchlistTvsEventFake extends Fake implements WatchlistTvSeriesEvent {}

class WatchlistTvsStateFake extends Fake implements WatchlistTvSeriesState {}

@GenerateMocks([TvSeriesDetailBloc])
void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendTvsBloc mockRecommendationTvsBloc;
  late MockWatchlistTvsBloc mockWatchlistTvsBloc;

  setUpAll(() {
    registerFallbackValue(DetailTvEventFake());
    registerFallbackValue(DetailTvStateFake());
    registerFallbackValue(RecommendationTvsEventFake());
    registerFallbackValue(RecommendationTvsStateFake());
    registerFallbackValue(WatchlistTvsEventFake());
    registerFallbackValue(WatchlistTvsStateFake());
  });

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
    mockRecommendationTvsBloc = MockRecommendTvsBloc();
    mockWatchlistTvsBloc = MockWatchlistTvsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockDetailTvBloc,
        ),
        BlocProvider<RecommendTvSeriesBloc>(
          create: (context) => mockRecommendationTvsBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => mockWatchlistTvsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Tv Series Detail test page bloc', () {
    testWidgets(
        'Watchlist button should display add icon when Tv not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailTvBloc.state).thenReturn(
        TvSeriesDetailLoaded(testTvSeriesDetail),
      );
      when(() => mockRecommendationTvsBloc.state).thenReturn(
        RecommendTvSeriesLoaded(testTvSeriesList),
      );
      when(() => mockWatchlistTvsBloc.state).thenReturn(
        WatchlistTvSeriesStatusLoaded(false),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when Tv is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailTvBloc.state).thenReturn(
        TvSeriesDetailLoaded(testTvSeriesDetail),
      );
      when(() => mockRecommendationTvsBloc.state).thenReturn(
        RecommendTvSeriesLoaded(testTvSeriesList),
      );
      when(() => mockWatchlistTvsBloc.state).thenReturn(
        WatchlistTvSeriesStatusLoaded(true),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(DetailTvPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });
  });
}

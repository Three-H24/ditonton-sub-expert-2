import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTopRatedTvBloc extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvState extends Fake implements TopRatedTvSeriesState {}

@GenerateMocks([TopRatedTvSeriesBloc])
void main() {
  late MockTopRatedTvBloc mockTopRatedTvsBloc;

  setUp(() {
    mockTopRatedTvsBloc = MockTopRatedTvBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Top Rated Test Page', () {
    testWidgets('Should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvsBloc.state).thenReturn(
        TopRatedTvSeriesLoading(),
      );

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvsBloc.state).thenReturn(
        TopRatedTvSeriesLoaded(testTvSeriesList),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvsBloc.state).thenReturn(
        TopRatedTvSeriesError('error_message'),
      );

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

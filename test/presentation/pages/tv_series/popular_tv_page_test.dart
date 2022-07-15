import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc_provider/tv_provider/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/tv_pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularTvSeriesBloc extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class FakePopularTvEvent extends Fake implements PopularTvSeriesEvent {}

class FakePopularTvState extends Fake implements PopularTvSeriesState {}

@GenerateMocks([PopularTvSeriesBloc])
void main() {
  late MockPopularTvSeriesBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvSeriesBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Popular Tv Page Test', () {
    testWidgets('Should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(
        PopularTvSeriesLoading(),
      );

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(
        PopularTvSeriesLoaded(testTvSeriesList),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(
        PopularTvSeriesError('error_message'),
      );

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

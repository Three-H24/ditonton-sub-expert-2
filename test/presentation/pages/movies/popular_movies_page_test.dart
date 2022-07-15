import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/movie_pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class FakePopularMovieEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMovieState extends Fake implements PopularMoviesState {}

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMovieBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMovieBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockPopularMoviesBloc.state).thenReturn(
          PopularMoviesLoading(),
        );

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockPopularMoviesBloc.state).thenReturn(
          PopularMoviesLoaded(testMovieList),
        );

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockPopularMoviesBloc.state).thenReturn(
          PopularMoviesError('error_message'),
        );

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}


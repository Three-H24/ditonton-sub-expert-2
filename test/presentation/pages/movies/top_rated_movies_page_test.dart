import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc_provider/movie_provider/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/movie_pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class FakeTopRatedMovieEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMovieState extends Fake implements TopRatedMoviesState {}

@GenerateMocks([TopRatedMoviesBloc])
void main() {
  late MockTopRatedMovieBloc mockTopRatedMoviesBloc;

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMovieBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockTopRatedMoviesBloc.state).thenReturn(
          TopRatedMoviesLoading(),
        );

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockTopRatedMoviesBloc.state).thenReturn(
          TopRatedMoviesLoaded(testMovieList),
        );

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockTopRatedMoviesBloc.state).thenReturn(
          TopRatedMoviesError('error_message'),
        );

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}

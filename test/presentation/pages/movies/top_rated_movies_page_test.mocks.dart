// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/pages/movies/top_rated_movies_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart'
    as _i2;
import 'package:ditonton/presentation/bloc_provider/movie_provider/top_rated_movies/top_rated_movies_bloc.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetTopRatedMovies_0 extends _i1.Fake
    implements _i2.GetTopRatedMovies {}

class _FakeTopRatedMoviesState_1 extends _i1.Fake
    implements _i3.TopRatedMoviesState {}

class _FakeStreamSubscription_2<T> extends _i1.Fake
    implements _i4.StreamSubscription<T> {}

/// A class which mocks [TopRatedMoviesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedMoviesBloc extends _i1.Mock
    implements _i3.TopRatedMoviesBloc {
  MockTopRatedMoviesBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedMovies get getTopRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedMovies),
          returnValue: _FakeGetTopRatedMovies_0()) as _i2.GetTopRatedMovies);
  @override
  _i3.TopRatedMoviesState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeTopRatedMoviesState_1()) as _i3.TopRatedMoviesState);
  @override
  _i4.Stream<_i3.TopRatedMoviesState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.TopRatedMoviesState>.empty())
          as _i4.Stream<_i3.TopRatedMoviesState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.TopRatedMoviesEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.TopRatedMoviesEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>
      transformEvents(
              _i4.Stream<_i3.TopRatedMoviesEvent>? events,
              _i5.TransitionFunction<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>?
                  transitionFn) =>
          (super.noSuchMethod(
                  Invocation.method(#transformEvents, [events, transitionFn]),
                  returnValue:
                      Stream<_i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>.empty())
              as _i4.Stream<
                  _i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>);
  @override
  void emit(_i3.TopRatedMoviesState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.TopRatedMoviesEvent>(
          _i5.EventHandler<E, _i3.TopRatedMoviesState>? handler,
          {_i5.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i3.TopRatedMoviesState> mapEventToState(
          _i3.TopRatedMoviesEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i3.TopRatedMoviesState>.empty())
          as _i4.Stream<_i3.TopRatedMoviesState>);
  @override
  void onTransition(
          _i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>
      transformTransitions(
              _i4.Stream<_i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue:
                      Stream<_i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>.empty())
              as _i4.Stream<
                  _i5.Transition<_i3.TopRatedMoviesEvent, _i3.TopRatedMoviesState>>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.StreamSubscription<_i3.TopRatedMoviesState> listen(
          void Function(_i3.TopRatedMoviesState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_2<_i3.TopRatedMoviesState>())
          as _i4.StreamSubscription<_i3.TopRatedMoviesState>);
  @override
  void onChange(_i5.Change<_i3.TopRatedMoviesState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

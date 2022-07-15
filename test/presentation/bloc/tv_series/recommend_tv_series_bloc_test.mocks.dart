// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/bloc/tv_series/recommend_tv_series_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i7;
import 'package:dartz/dartz.dart' as _i6;
import 'package:ditonton/common/failure.dart' as _i8;
import 'package:ditonton/domain/entities/tv_entities/tv.dart' as _i9;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i5;
import 'package:ditonton/domain/usecases/tv_usecases/get_tv_recommendations.dart'
    as _i2;
import 'package:ditonton/presentation/bloc_provider/tv_provider/recommend_tv_series/recommend_tv_series_bloc.dart'
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

class _FakeGetTvRecommendations_0 extends _i1.Fake
    implements _i2.GetTvRecommendations {}

class _FakeRecommendTvSeriesState_1 extends _i1.Fake
    implements _i3.RecommendTvSeriesState {}

class _FakeStreamSubscription_2<T> extends _i1.Fake
    implements _i4.StreamSubscription<T> {}

class _FakeTvRepository_3 extends _i1.Fake implements _i5.TvRepository {}

class _FakeEither_4<L, R> extends _i1.Fake implements _i6.Either<L, R> {}

/// A class which mocks [RecommendTvSeriesBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockRecommendTvSeriesBloc extends _i1.Mock
    implements _i3.RecommendTvSeriesBloc {
  MockRecommendTvSeriesBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations_0()) as _i2.GetTvRecommendations);
  @override
  _i3.RecommendTvSeriesState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeRecommendTvSeriesState_1())
          as _i3.RecommendTvSeriesState);
  @override
  _i4.Stream<_i3.RecommendTvSeriesState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.RecommendTvSeriesState>.empty())
          as _i4.Stream<_i3.RecommendTvSeriesState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.RecommendTvSeriesEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.RecommendTvSeriesEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>
      transformEvents(
              _i4.Stream<_i3.RecommendTvSeriesEvent>? events,
              _i7.TransitionFunction<_i3.RecommendTvSeriesEvent,
                      _i3.RecommendTvSeriesState>?
                  transitionFn) =>
          (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>.empty()) as _i4
              .Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>);
  @override
  void emit(_i3.RecommendTvSeriesState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.RecommendTvSeriesEvent>(
          _i7.EventHandler<E, _i3.RecommendTvSeriesState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i3.RecommendTvSeriesState> mapEventToState(
          _i3.RecommendTvSeriesEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i3.RecommendTvSeriesState>.empty())
          as _i4.Stream<_i3.RecommendTvSeriesState>);
  @override
  void onTransition(
          _i7.Transition<_i3.RecommendTvSeriesEvent,
                  _i3.RecommendTvSeriesState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>
      transformTransitions(
              _i4.Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue:
                      Stream<_i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>.empty())
              as _i4.Stream<
                  _i7.Transition<_i3.RecommendTvSeriesEvent, _i3.RecommendTvSeriesState>>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.StreamSubscription<_i3.RecommendTvSeriesState> listen(
          void Function(_i3.RecommendTvSeriesState)? onData,
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
              returnValue:
                  _FakeStreamSubscription_2<_i3.RecommendTvSeriesState>())
          as _i4.StreamSubscription<_i3.RecommendTvSeriesState>);
  @override
  void onChange(_i7.Change<_i3.RecommendTvSeriesState>? change) =>
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

/// A class which mocks [GetTvRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvRecommendations extends _i1.Mock
    implements _i2.GetTvRecommendations {
  MockGetTvRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.TvRepository get tvRepository =>
      (super.noSuchMethod(Invocation.getter(#tvRepository),
          returnValue: _FakeTvRepository_3()) as _i5.TvRepository);
  @override
  _i4.Future<_i6.Either<_i8.Failure, List<_i9.Tv>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i6.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither_4<_i8.Failure, List<_i9.Tv>>()))
          as _i4.Future<_i6.Either<_i8.Failure, List<_i9.Tv>>>);
}

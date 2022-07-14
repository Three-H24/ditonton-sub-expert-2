import 'dart:convert';

import 'package:ditonton/data/models/tvmodels/model_tv.dart';
import 'package:ditonton/data/models/tvmodels/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = ModelTv(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2010-06-08",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvResponseModel = TvResponse(tvList: <ModelTv>[tTvModel]);

  group('Response fromJson', () {
    test('should return a valid Model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonToMap =
      json.decode(readJson('dummy_data/tv_series/tv_on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonToMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('Response toJson', () {
    test('should return a JSON to map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "first_air_date": "2010-06-08",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
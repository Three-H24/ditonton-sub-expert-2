import 'package:ditonton/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/data/datasources/tv/local_data_source.dart';
import 'package:ditonton/data/datasources/tv/remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
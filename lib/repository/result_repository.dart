import 'package:race_tracking_app/models/result.dart';

abstract class ResultRepository {
  Future<List<Result>> getResults();
  Future<void> addResult(Result result);
  Future<void> deleteResult(String bib);
  Future<void> resetResults();
  Future<void> saveAllResults(List<Result> results);
}

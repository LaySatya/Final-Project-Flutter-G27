
import '../models/result.dart';

abstract class ResultRepository {
  Future<List<Result>> getResults();
  Future<void> addResult(Result result);
  Future<void> deleteResult(String bib);
  Future<void> resetResults();
}

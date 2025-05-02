
import 'package:race_tracking_app/repository/result_repository.dart';
import '../../models/result.dart';


class MockResultRepository implements ResultRepository{
  final List<Result> _dummyResults = [];

  @override
  Future<List<Result>> getResults() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _dummyResults;
  }

  @override
  Future<void> addResult(Result result) async {
    _dummyResults.add(result);
  }

  @override
  Future<void> deleteResult(String bib) async {
    _dummyResults.removeWhere((r) => r.bib == bib);
  }

  @override
  Future<void> resetResults() async {
    _dummyResults.clear();
  }
}

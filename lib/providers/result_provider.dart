import 'package:flutter/material.dart';

import '../models/result.dart';
import '../repository/result_repository.dart';

class ResultProvider with ChangeNotifier {
  final ResultRepository _repository; // connect to repository

  List<Result> _results = [];

  ResultProvider(this._repository); // pass repository when creating provider

  List<Result> get results => _results;

  /// Load results from repository
  Future<void> loadResults() async {
    _results = await _repository.getResults();
    notifyListeners();
  }

  /// Add a new result manually
  Future<void> addResult(Result result) async {
    await _repository.addResult(result);
    await loadResults();
  }

  /// Delete a result
  Future<void> deleteResult(String bib) async {
    await _repository.deleteResult(bib);
    await loadResults();
  }

  /// Reset all results
  Future<void> resetResults() async {
    await _repository.resetResults();
    await loadResults();
  }
}

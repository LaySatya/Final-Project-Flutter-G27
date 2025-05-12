import 'package:flutter/material.dart';
import '../models/participant.dart';
import '../models/result.dart';
import '../repository/result_repository.dart';

class ResultProvider with ChangeNotifier {
  final ResultRepository _repository;
  List<Result> _results = [];

  ResultProvider(this._repository);

  List<Result> get results => _results;

  Future<void> loadResults() async {
    _results = await _repository.getResults();
    notifyListeners();
  }

  Future<void> calculateResults(List<Participant> participants) async {
    // Filter participants with at least one segment time
    final validParticipants =
        participants
            .where((p) => p.segments.values.any((s) => s.timeInSeconds > 0))
            .toList();

    // Sort by total time
    validParticipants.sort((a, b) => a.totalTime.compareTo(b.totalTime));

    // Convert to results
    final results =
        validParticipants
            .asMap()
            .map((index, participant) {
              return MapEntry(
                index,
                Result(
                  rank: index + 1,
                  bib: participant.id,
                  name: participant.name,
                  totalTime: participant.totalTime,
                  segmentTimes: participant.segments.map(
                    (key, value) => MapEntry(key, value.timeInSeconds),
                  ),
                ),
              );
            })
            .values
            .toList();

    await _repository.saveAllResults(results);
    _results = results;
    notifyListeners();
  }

  Future<void> resetResults() async {
    await _repository.resetResults();
    _results = [];
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../models/participant.dart';
import '../models/segment.dart';
import '../repository/participant_repository.dart';

class ParticipantProvider with ChangeNotifier {
  final ParticipantRepository _repository;

  List<Participant> _participants = [];

  ParticipantProvider(this._repository);

  List<Participant> get participants => _participants;

  Future<void> loadParticipants() async {
    _participants = await _repository.getParticipants();
    notifyListeners();
  }

  Future<void> addParticipant(String name, String bib, Map<SegmentType, Segment> segments) async {
    final isBibExist = _participants.any((p) => p.bib == bib);
    if (isBibExist) {
      throw Exception('Participant with BIB number $bib already exists');
    }
    final newParticipant = Participant(id: bib, bib: bib, name: name, segments: segments);
    await _repository.addParticipant(newParticipant);
    await loadParticipants();
  }

  Future<void> deleteParticipant(String bib) async {
    await _repository.deleteParticipant(bib);
    await loadParticipants();
  }

  Future<void> updateParticipant(String oldBib, String newName, String newBib, Map<SegmentType, Segment> segments) async {
    final isBibExist = _participants.any((p) => p.bib == newBib && p.bib != oldBib);
    if (isBibExist) {
      throw Exception('The BIB ID $newBib is already taken by another participant.');
    }
    final updatedParticipant = Participant(id: newBib, bib: newBib, name: newName, segments: segments);
    await _repository.updateParticipant(oldBib, updatedParticipant);
    await loadParticipants();
  }

  Future<void> trackSegment(String bib, SegmentType type, int timeInSeconds) async {
    final participant = _participants.firstWhere((p) => p.bib == bib, orElse: () => throw Exception('Participant not found'));
    if (!participant.segments[type]!.isTracked) {
      participant.segments[type]!
        ..isTracked = true
        ..timeInSeconds = timeInSeconds;
      notifyListeners();
    }
  }

  Future<void> untrackSegment(String bib, SegmentType type) async {
    final participant = _participants.firstWhere((p) => p.bib == bib, orElse: () => throw Exception('Participant not found'));
    if (participant.segments[type]!.isTracked) {
      participant.segments[type]!
        ..isTracked = false
        ..timeInSeconds = 0;
      notifyListeners();
    }
  }

  Future<void> resetParticipants() async {
  for (var participant in _participants) {
    await _repository.resetParticipant(participant.bib); // Reset each participant
  }
  await loadParticipants(); // Reload the participants list after resetting
}

}

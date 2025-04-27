import 'package:flutter/material.dart';

import '../mock/mock_participants.dart'; // Your dummy data
import '../models/participant.dart';
import '../models/segment.dart';

class ParticipantProvider with ChangeNotifier {
  List<Participant> _participants = dummyParticipants;

  List<Participant> get participants => _participants;

 void addParticipant(String name, String bib, Map<SegmentType, Segment> segments) {
    _participants.add(Participant(bib: bib, name: name, segments: segments));
    notifyListeners();
  }

  void deleteParticipant(String bib) {
    _participants.removeWhere((participant) => participant.bib == bib);
    notifyListeners();
  }

  void updateParticipant(String oldBib, String newName, String newBib, Map<SegmentType, Segment> segments) {
    final participantIndex = _participants.indexWhere((p) => p.bib == oldBib);
    if (participantIndex != -1) {
      _participants[participantIndex] = Participant(
        bib: newBib,
        name: newName,
        segments: segments,
      );
      notifyListeners();
    }
  }

  /// Track a segment for a participant
  void trackSegment(String bib, SegmentType type, int timeInSeconds) {
    final participant = _participants.firstWhere((p) => p.bib == bib, orElse: () => throw Exception('Participant not found'));
    if (!participant.segments[type]!.isTracked) {
      participant.segments[type]!
        ..isTracked = true
        ..timeInSeconds = timeInSeconds;
      notifyListeners();
    }
  }

  /// Untrack a segment for a participant
  void untrackSegment(String bib, SegmentType type) {
    final participant = _participants.firstWhere((p) => p.bib == bib, orElse: () => throw Exception('Participant not found'));
    if (participant.segments[type]!.isTracked) {
      participant.segments[type]!
        ..isTracked = false
        ..timeInSeconds = 0;
      notifyListeners();
    }
  }

  /// Reset all participants
  void resetParticipants() {
    for (var p in _participants) {
      p.segments.forEach((key, segment) {
        segment.isTracked = false;
        segment.timeInSeconds = 0;
      });
    }
    notifyListeners();
  }
}

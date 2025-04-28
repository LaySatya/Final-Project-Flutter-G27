import '../mock/mock_participants.dart';
import '../models/participant.dart';

class ParticipantRepository {
  List<Participant> _participants = dummyParticipants;

  Future<List<Participant>> getParticipants() async {
    // Simulate a delay as if fetching from a server
    await Future.delayed(const Duration(milliseconds: 300));
    return _participants;
  }

  Future<void> addParticipant(Participant participant) async {
    _participants.add(participant);
  }

  Future<void> deleteParticipant(String bib) async {
    _participants.removeWhere((p) => p.bib == bib);
  }

  Future<void> updateParticipant(String oldBib, Participant updatedParticipant) async {
    final index = _participants.indexWhere((p) => p.bib == oldBib);
    if (index != -1) {
      _participants[index] = updatedParticipant;
    }
  }

  Future<void> resetParticipants() async {
    for (var p in _participants) {
      p.segments.forEach((key, segment) {
        segment.isTracked = false;
        segment.timeInSeconds = 0;
      });
    }
  }
}

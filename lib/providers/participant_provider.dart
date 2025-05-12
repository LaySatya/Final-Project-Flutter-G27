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

  Future<void> addParticipant(
    String name,
    String bib,
    Map<SegmentType, Segment> segments,
  ) async {
    final isBibExist = _participants.any((p) => p.bib == bib);
    if (isBibExist) {
      throw Exception('Participant with BIB number $bib already exists');
    }
    final newParticipant = Participant(
      id:
          DateTime.now().millisecondsSinceEpoch
              .toString(), // new participant id
      bib: bib,
      name: name,
      segments: segments,
    );
    await _repository.addParticipant(newParticipant);
    await loadParticipants();
  }

  Future<void> deleteParticipant(String id) async {
    await _repository.deleteParticipant(id);
    await loadParticipants();
  }

  Future<void> updateParticipant(
    String id,
    String newName,
    String newBib,
    Map<SegmentType, Segment> segments,
  ) async {
    // Find the existing participant
    final existingParticipant = _participants.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Participant not found'),
    );

    // Check if new BIB is already taken by another participant
    if (newBib != existingParticipant.bib &&
        _participants.any((p) => p.bib == newBib)) {
      throw Exception('BIB number $newBib is already taken');
    }

    // Create updated participant
    final updatedParticipant = Participant(
      id: id, // Keep the same ID
      bib: newBib,
      name: newName,
      segments: segments,
    );

    await _repository.updateParticipant(id, updatedParticipant);
    await loadParticipants();
  }

  Future<void> resetParticipant({
    required String participantId,
    bool resetBib = false,
    bool resetName = false,
    String? newBib,
    String? newName,
  }) async {
    // Find the existing participant
    final participant = _participants.firstWhere(
      (p) => p.id == participantId,
      orElse: () => throw Exception('Participant not found'),
    );

    // Validate new BIB if provided
    if (newBib != null || resetBib) {
      final bibToUse = newBib ?? '';
      if (bibToUse.isEmpty) throw Exception('BIB cannot be empty');
      if (_participants.any(
        (p) => p.bib == bibToUse && p.id != participantId,
      )) {
        throw Exception('BIB number $bibToUse is already taken');
      }
    }

    // Create a new segments map with all segments reset
    final resetSegments = Map<SegmentType, Segment>.fromIterable(
      SegmentType.values,
      key: (type) => type,
      value: (type) => Segment(type: type),
    );

    // Create updated participant
    final resetParticipant = Participant(
      id: participant.id,
      bib: resetBib ? newBib ?? '' : participant.bib,
      name: resetName ? newName ?? '' : participant.name,
      segments: resetSegments,
    );

    await _repository.updateParticipant(participantId, resetParticipant);
    await loadParticipants();
  }

  // reset all participants
  Future<void> resetAllParticipants() async {
    for (final participant in _participants) {
      await resetParticipant(participantId: participant.id);
    }
    await loadParticipants();
  }
}

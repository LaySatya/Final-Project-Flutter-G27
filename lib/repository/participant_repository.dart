
import '../models/participant.dart';

abstract class ParticipantRepository {
  Future<List<Participant>> getParticipants();
  Future<void> addParticipant(Participant participant);
  Future<void> updateParticipant(String oldBib, Participant updatedParticipant);
  Future<void> deleteParticipant(String bib);
  Future<void> resetParticipants();
}

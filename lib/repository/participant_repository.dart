import '../models/participant.dart';

abstract class ParticipantRepository {
  Future<List<Participant>> getParticipants();
  Future<Participant> addParticipant(Participant participant);
  Future<void> updateParticipant(String id, Participant updated);
  Future<void> deleteParticipant(String id);
  Future<void> resetParticipant(String id);
}

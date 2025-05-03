

// import 'package:race_tracking_app/repository/participant_repository.dart';
// import '../../models/participant.dart';
// import '../../mock/mock_participants.dart';


// class MockParticipantRepository implements ParticipantRepository {
//   List<Participant> _participants = dummyParticipants;

//   @override
//   Future<List<Participant>> getParticipants() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return _participants;
//   }

//   @override
//   Future<void> addParticipant(Participant participant) async {
//     _participants.add(participant);
//   }

//   @override
//   Future<void> deleteParticipant(String bib) async {
//     _participants.removeWhere((p) => p.bib == bib);
//   }

//   @override
//   Future<void> updateParticipant(String oldBib, Participant updatedParticipant) async {
//     final index = _participants.indexWhere((p) => p.bib == oldBib);
//     if (index != -1) {
//       _participants[index] = updatedParticipant;
//     }
//   }

//   @override
//   Future<void> resetParticipants() async {
//     for (var p in _participants) {
//       p.segments.forEach((_, segment) {
//         segment.isTracked = false;
//         segment.timeInSeconds = 0;
//       });
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/repository/participant_repository.dart';


class FirebaseParticipantRepository implements ParticipantRepository {
  static const String baseUrl = 'https://racetrackingapp-84859-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String collection = 'participants';

  @override
  Future<Participant> addParticipant(Participant participant) async {
    final uri = Uri.parse('$baseUrl/$collection.json');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(participant.toJson()),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to add participant");
    }
    final id = jsonDecode(response.body)['name'];
    return Participant(
      id: id,
      bib: participant.bib,
      name: participant.name,
      segments: participant.segments,
    );
  }

  @override
  Future<void> deleteParticipant(String id) async {
    final uri = Uri.parse('$baseUrl/$collection/$id.json');
    final response = await http.delete(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to delete participant");
    }
  }

  @override
  Future<List<Participant>> getParticipants() async {
    final uri = Uri.parse('$baseUrl/$collection.json');
    final response = await http.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to fetch participants");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];

    return data.entries
        .map((e) => Participant.fromJson(e.key, e.value))
        .toList();
  }

  @override
  Future<void> updateParticipant(String id, Participant updated) async {
    final uri = Uri.parse('$baseUrl/$collection/$id.json');
    final response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updated.toJson()),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to update participant");
    }
  }
  @override
Future<void> resetParticipant(String id) async {
  final uri = Uri.parse('$baseUrl/$collection/$id/segments.json');

  // Default segment reset data (assuming all 3 segments exist)
  final defaultSegments = {
    'swim': {'type': 'swim', 'isTracked': false, 'timeInSeconds': 0},
    'cycle': {'type': 'cycle', 'isTracked': false, 'timeInSeconds': 0},
    'run': {'type': 'run', 'isTracked': false, 'timeInSeconds': 0},
  };

  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(defaultSegments),
  );

  if (response.statusCode != HttpStatus.ok) {
    throw Exception("Failed to reset participant segments");
  }
}

}

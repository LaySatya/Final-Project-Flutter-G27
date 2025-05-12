import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/repository/segment_tracking_repository.dart';

class FirebaseSegmentTrackingRepository extends SegmentTrackingRepository {
  final String baseUrl;
  final String collection;

  FirebaseSegmentTrackingRepository({
    required this.baseUrl,
    required this.collection,
  });

  @override
  Future<void> trackSegment(String pId, SegmentType segmentType) async {
    final participantId = await _getParticipantIdById(pId);
    if (participantId == null) {
      throw Exception("Participant with Id $participantId not found");
    }

    final segment = Segment(type: segmentType, isTracked: true);
    final uri = Uri.parse(
      '$baseUrl/$collection/$participantId/segments/${segmentType.name}.json',
    );
    final response = await http.patch(uri, body: jsonEncode(segment.toJson()));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to track segment: ${response.body}");
    }
  }

  Future<String?> _getParticipantIdById(String id) async {
    final uri = Uri.parse('$baseUrl/$collection.json');
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to fetch participants for bib lookup.");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>?;

    if (data == null) return null;

    for (final entry in data.entries) {
      final participant = entry.value as Map<String, dynamic>;
      if (participant['bib'] == id) {
        return entry.key;
      }
    }

    return null;
  }

  @override
  Future<void> untrackSegment(
    String participantId,
    SegmentType segmentType,
  ) async {
    final segment = Segment(type: segmentType, isTracked: false);
    final uri = Uri.parse(
      '$baseUrl/$collection/$participantId/segments/${segmentType.name}.json',
    );
    final response = await http.patch(uri, body: jsonEncode(segment.toJson()));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to untrack segment: ${response.body}");
    }
  }

  @override
  Future<void> finishSegment(
    String participantId,
    SegmentType segmentType,
    int timeInSeconds,
  ) async {
    final segment = Segment(
      type: segmentType,
      isTracked: true,
      timeInSeconds: timeInSeconds,
    );

    final uri = Uri.parse(
      '$baseUrl/$collection/$participantId/segments/${segmentType.name}.json',
    );
    final response = await http.patch(uri, body: jsonEncode(segment.toJson()));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to finish segment: ${response.body}");
    }
  }

  // reset traking
  @override
  Future<void> resetTracking() async {
    final uri = Uri.parse('$baseUrl/$collection.json');
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Failed to get data: ${response.body}");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>?;

    if (data == null) return;

    for (final participantId in data.keys) {
      final resetUri = Uri.parse(
        '$baseUrl/$collection/$participantId/segments.json',
      );
      final response = await http.delete(resetUri);

      if (response.statusCode != HttpStatus.ok) {
        throw Exception(
          "Failed to reset segments for $participantId: ${response.body}",
        );
      }
    }
  }
}

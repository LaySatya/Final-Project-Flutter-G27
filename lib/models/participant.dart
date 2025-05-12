import 'package:race_tracking_app/models/segment.dart';

class Participant {
  final String id;
  final String bib;
  final String name;
  final Map<SegmentType, Segment> segments;

  Participant({
    required this.id,
    required this.bib,
    required this.name,
    required this.segments,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bib': bib,
      'name': name,
      'segments': segments.map(
        (key, value) => MapEntry(key.name, value.toJson()),
      ),
    };
  }

  factory Participant.fromJson(String id, Map<String, dynamic> json) {
    try {
      final segmentsJson = json['segments'] as Map<String, dynamic>?;
      final segments =
          segmentsJson?.map(
            (key, value) => MapEntry(
              SegmentType.values.firstWhere((e) => e.name == key),
              Segment.fromJson(value),
            ),
          ) ??
          {};

      return Participant(
        id: id,
        bib: json['bib'] ?? 'unknown',
        name: json['name'] ?? 'unknown',
        segments: segments,
      );
    } catch (e) {
      return Participant(id: id, bib: 'error', name: 'error', segments: {});
    }
  }

  int get totalTime {
    if (segments.isEmpty) return 0;
    return segments.values.fold(0, (sum, seg) => sum + seg.timeInSeconds);
  }
}

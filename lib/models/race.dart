import 'package:race_tracking_app/models/segment.dart';

enum RaceStatus { notStarted, ongoing, finished }

class Race {
  final String name;
  final DateTime dateTime;
  RaceStatus status;
  int elapsedTime;
  final List<Segment> segments;

  Race({
    required this.name,
    required this.dateTime,
    required this.status,
    required this.elapsedTime,
    required this.segments,
  });

  String get statusString => status.toString().split('.').last;
}

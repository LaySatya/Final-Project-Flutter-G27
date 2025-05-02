import 'package:race_tracking_app/models/segment.dart';

class Result {
  final int rank;
  final String bib;
  final String name;
  final int totalTime;
  final List<Segment> segments;

  Result({
    required this.rank,
    required this.bib,
    required this.name,
    required this.totalTime,
    required this.segments,
  });

  String get rankString => rank.toString();
}

import 'segment.dart';

class Participant {
  final String bib;
  final String name;
  Map<SegmentType, Segment> segments;

  Participant({
    required this.bib,
    required this.name,
    required this.segments,
  });

  int get totalTime => segments.values.fold(0, (sum, seg) => sum + seg.timeInSeconds);
}

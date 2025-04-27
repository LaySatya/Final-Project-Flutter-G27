enum SegmentType { swim, cycle, run }

class Segment {
  final SegmentType type;
  bool isTracked;
  int timeInSeconds; // Time when the participant finishes this segment

  Segment({
    required this.type,
    this.isTracked = false,
    this.timeInSeconds = 0,
  });
}

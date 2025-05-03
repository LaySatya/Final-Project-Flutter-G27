enum SegmentType { swim, cycle, run }

String segmentTypeToString(SegmentType type) => type.name;

SegmentType segmentTypeFromString(String value) =>
    SegmentType.values.firstWhere((e) => e.name == value);

class Segment {
  final SegmentType type;
  bool isTracked;
  int timeInSeconds;

  Segment({
    required this.type,
    this.isTracked = false,
    this.timeInSeconds = 0,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'isTracked': isTracked,
        'timeInSeconds': timeInSeconds,
      };

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        type: SegmentType.values.firstWhere((e) => e.name == json['type']),
        isTracked: json['isTracked'],
        timeInSeconds: json['timeInSeconds'],
      );
}

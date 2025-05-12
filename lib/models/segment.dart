enum SegmentType { swim, cycle, run }

class Segment {
  final SegmentType type;
  bool isTracked;
  int timeInSeconds;
  DateTime? startTime;
  DateTime? endTime;

  Segment({
    required this.type,
    this.isTracked = false,
    this.timeInSeconds = 0,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'isTracked': isTracked,
    'timeInSeconds': timeInSeconds,
    'startTime': startTime?.toIso8601String(),
    'endTime': endTime?.toIso8601String(),
  };

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    type: SegmentType.values.firstWhere((e) => e.name == json['type']),
    isTracked: json['isTracked'] ?? false,
    timeInSeconds: json['timeInSeconds'] ?? 0,
    startTime:
        json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
    endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
  );
}

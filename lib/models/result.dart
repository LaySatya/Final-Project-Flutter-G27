import 'package:race_tracking_app/models/segment.dart';

class Result {
  final int rank;
  final String bib;
  final String name;
  final int totalTime;
  final Map<SegmentType, int> segmentTimes;

  Result({
    required this.rank,
    required this.bib,
    required this.name,
    required this.totalTime,
    required this.segmentTimes,
  });

  String get rankString => rank.toString();

  Map<String, dynamic> toJson() => {
    'rank': rank,
    'bib': bib,
    'name': name,
    'totalTime': totalTime,
    'segmentTimes': segmentTimes.map((key, value) => MapEntry(key.name, value)),
  };

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    rank: json['rank'],
    bib: json['bib'],
    name: json['name'],
    totalTime: json['totalTime'],
    segmentTimes: (json['segmentTimes'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        SegmentType.values.firstWhere((e) => e.name == key),
        value as int,
      ),
    ),
  );
}

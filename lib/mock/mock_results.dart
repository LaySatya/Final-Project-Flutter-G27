import 'package:race_tracking_app/models/result.dart';
import 'package:race_tracking_app/models/segment.dart';

List<Result> dummyResults = [
  Result(
    rank: 1,
    bib: '012',
    name: 'Ronan',
    totalTime: 4514,
    segments: [
      Segment(type: SegmentType.swim, isTracked: true, timeInSeconds: 1200),
      Segment(type: SegmentType.cycle, isTracked: true, timeInSeconds: 2000),
      Segment(type: SegmentType.run, isTracked: true, timeInSeconds: 1314),
    ],
  ),
  Result(
    rank: 2,
    bib: '013',
    name: 'Sokea',
    totalTime: 4521,
    segments: [
      Segment(type: SegmentType.swim, isTracked: true, timeInSeconds: 1250),
      Segment(type: SegmentType.cycle, isTracked: true, timeInSeconds: 2010),
      Segment(type: SegmentType.run, isTracked: true, timeInSeconds: 1261),
    ],
  ),
];

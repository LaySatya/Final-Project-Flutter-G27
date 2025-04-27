import 'package:race_tracking_app/models/segment.dart';

import '../models/participant.dart';

List<Participant> dummyParticipants = [
  Participant(
    bib: '012',
    name: 'Ronan',
    segments: {
      SegmentType.swim: Segment(type: SegmentType.swim),
      SegmentType.cycle: Segment(type: SegmentType.cycle),
      SegmentType.run: Segment(type: SegmentType.run),
    },
  ),
  Participant(
    bib: '013',
    name: 'Sokea',
    segments: {
      SegmentType.swim: Segment(type: SegmentType.swim),
      SegmentType.cycle: Segment(type: SegmentType.cycle),
      SegmentType.run: Segment(type: SegmentType.run),
    },
  ),
  Participant(
    bib: '014',
    name: 'Him',
    segments: {
      SegmentType.swim: Segment(type: SegmentType.swim),
      SegmentType.cycle: Segment(type: SegmentType.cycle),
      SegmentType.run: Segment(type: SegmentType.run),
    },
  ),
   Participant(
    bib: '015',
    name: 'Kaka',
    segments: {
      SegmentType.swim: Segment(type: SegmentType.swim),
      SegmentType.cycle: Segment(type: SegmentType.cycle),
      SegmentType.run: Segment(type: SegmentType.run),
    },
  ),
];

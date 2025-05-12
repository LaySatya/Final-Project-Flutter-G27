// import 'package:race_tracking_app/models/segment.dart';
// import 'segment_tracking_repository.dart';

// class MockSegmentTrackingRepository implements SegmentTrackingRepository {
//   final Map<String, List<Segment>> _participantSegments = {};

//   @override
//   Future<void> trackSegment(
//     String participantBib,
//     SegmentType segmentType,
//   ) async {
//     final segments = _getOrCreateSegments(participantBib);
//     final segment = segments.firstWhere((s) => s.type == segmentType);
//     segment.isTracked = true;
//   }

//   @override
//   Future<void> untrackSegment(
//     String participantBib,
//     SegmentType segmentType,
//   ) async {
//     final segments = _getOrCreateSegments(participantBib);
//     final segment = segments.firstWhere((s) => s.type == segmentType);
//     segment.isTracked = false;
//   }

//   @override
//   Future<void> finishSegment(
//     String participantBib,
//     SegmentType segmentType,
//   ) async {
//     final segments = _getOrCreateSegments(participantBib);
//     final segment = segments.firstWhere((s) => s.type == segmentType);
//     segment.isTracked = false;
//   }

//   @override
//   Future<void> resetTracking() async {
//     _participantSegments.clear();
//   }

//   @override
//   List<Segment> getSegmentsForParticipant(String participantBib) {
//     return _getOrCreateSegments(participantBib);
//   }

//   @override
//   List<Segment> getAllTrackedSegments() {
//     return _participantSegments.values
//         .expand((segments) => segments)
//         .where((segment) => segment.isTracked)
//         .toList();
//   }

//   List<Segment> _getOrCreateSegments(String participantBib) {
//     if (!_participantSegments.containsKey(participantBib)) {
//       _participantSegments[participantBib] =
//           SegmentType.values.map((type) => Segment(type: type)).toList();
//     }
//     return _participantSegments[participantBib]!;
//   }
// }

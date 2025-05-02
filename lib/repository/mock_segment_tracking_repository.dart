
import 'package:race_tracking_app/models/segment.dart';
import 'segment_tracking_repository.dart';

class MockSegmentTrackingRepository implements SegmentTrackingRepository {
  final List<Segment> _segments;

  MockSegmentTrackingRepository()
      : _segments = SegmentType.values
            .map((type) => Segment(type: type))
            .toList();

  @override
  Future<void> trackSegment(SegmentType segmentType) async {
    final segment = _segments.firstWhere((s) => s.type == segmentType);
    segment.isTracked = true;
  }

  @override
  Future<void> untrackSegment(SegmentType segmentType) async {
    final segment = _segments.firstWhere((s) => s.type == segmentType);
    segment.isTracked = false;
  }

  @override
  Future<void> finishSegment(SegmentType segmentType) async {
    final segment = _segments.firstWhere((s) => s.type == segmentType);
    segment.isTracked = false;
  }

  @override
  Future<void> resetTracking() async {
    for (var segment in _segments) {
      segment.isTracked = false;
      segment.timeInSeconds = 0;
    }
  }

  @override
  List<Segment> getSegments() {
    return _segments;
  }
}

import 'package:race_tracking_app/models/segment.dart';

abstract class SegmentTrackingRepository {
  Future<void> trackSegment(SegmentType segmentType);
  Future<void> untrackSegment(SegmentType segmentType);
  Future<void> finishSegment(SegmentType segmentType);
  Future<void> resetTracking();
  List<Segment> getSegments();
}
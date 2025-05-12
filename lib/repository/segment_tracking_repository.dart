import 'package:race_tracking_app/models/segment.dart';

abstract class SegmentTrackingRepository {
  Future<void> trackSegment(String participantId, SegmentType segmentType);
  Future<void> untrackSegment(String participantId, SegmentType segmentType);
  Future<void> finishSegment(
    String participantId,
    SegmentType segmentType,
    int timeInSeconds,
  );
  Future<void> resetTracking();
}

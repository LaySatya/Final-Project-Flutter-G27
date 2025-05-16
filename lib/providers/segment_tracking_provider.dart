import 'package:flutter/material.dart';
// import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/repository/segment_tracking_repository.dart';

class SegmentTrackingProvider with ChangeNotifier {
  final SegmentTrackingRepository repository;
  final Map<String, DateTime> _segmentStartTimes = {};
  final Map<String, int> _segmentTimes = {};

  SegmentTrackingProvider({required this.repository});

  // final Map<String, Map<SegmentType, Segment>> _trackedSegments = {};

  // Start tracking for one participant
  Future<void> startSegmentTracking(
    String participantId,
    SegmentType segmentType,
  ) async {
    final key = '${participantId}_${segmentType.name}';

    if (_segmentStartTimes.containsKey(key)) return; // already tracking

    _segmentStartTimes[key] = DateTime.now();
    notifyListeners();
  }

  // Stop tracking for one participant and save time
  Future<void> finishSegmentTracking(
    String participantId,
    SegmentType segmentType,
  ) async {
    final key = '${participantId}_${segmentType.name}';
    final startTime = _segmentStartTimes[key];
    if (startTime == null) return;

    final timeInSeconds = DateTime.now().difference(startTime).inSeconds;
    _segmentTimes[key] = timeInSeconds;

    _segmentStartTimes.remove(key);

    await repository.finishSegment(participantId, segmentType, timeInSeconds);
    notifyListeners();
  }

  // Cancel/Untrack without recording time
  Future<void> untrackSegment(
    String participantId,
    SegmentType segmentType,
  ) async {
    final key = '${participantId}_${segmentType.name}';
    _segmentStartTimes.remove(key);
    notifyListeners();
  }

  // Get tracked time
  int getSegmentTime(String participantId, SegmentType segmentType) {
    final key = '${participantId}_${segmentType.name}';
    return _segmentTimes[key] ?? 0;
  }

  // Check if tracking is in progress
  bool isTracked(String participantId, SegmentType segmentType) {
    final key = '${participantId}_${segmentType.name}';
    return _segmentStartTimes.containsKey(key);
  }

  Segment? getTrackedSegment(String participantId, SegmentType segmentType) {
    final timeInSeconds = getSegmentTime(participantId, segmentType);
    if (timeInSeconds > 0) {
      return Segment(type: segmentType, timeInSeconds: timeInSeconds);
    }
    return null;
  }

  Future<void> resetTracking() async {
    _segmentStartTimes.clear();
    _segmentTimes.clear();
    await repository.resetTracking();
    notifyListeners();
  }
}

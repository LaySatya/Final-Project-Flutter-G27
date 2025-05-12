import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/repository/segment_tracking_repository.dart';

class SegmentTrackingProvider with ChangeNotifier {
  final SegmentTrackingRepository repository;
  final Map<String, DateTime> _segmentStartTimes = {};
  final Map<String, int> _segmentTimes = {}; // to store times for each segment

  SegmentTrackingProvider({required this.repository});

  final Map<String, Map<SegmentType, Segment>> _trackedSegments = {};

  void startTrackingAll(
    List<Participant> participants,
    SegmentType segmentType,
  ) {
    for (var participant in participants) {
      startSegmentTracking(participant.id, segmentType);
    }
  }

  void stopTrackingAll(SegmentType segment) {
    final now = DateTime.now();
    _trackedSegments.forEach((participantId, segments) {
      final trackedSegment = segments[segment];
      if (trackedSegment != null && trackedSegment.isTracked) {
        final duration = now.difference(trackedSegment.startTime!).inSeconds;
        segments[segment] = Segment(
          type: segment,
          isTracked: false,
          timeInSeconds: duration,
        );
      }
    });
    notifyListeners();
  }

  // Future<void> untrackSegment(
  //   String participantId,
  //   SegmentType segmentType,
  // ) async {
  //   _segmentStartTimes.remove('${participantId}_${segmentType.name}');
  //   notifyListeners();
  // }

  // bool isSegmentFinished(String participantId, SegmentType segmentType) {
  //   return _segmentTimes.containsKey('${participantId}_${segmentType.name}');
  // }

  // start tracking a segment
  Future<void> startSegmentTracking(
    String participantId,
    SegmentType segmentType,
  ) async {
    _segmentStartTimes['${participantId}_${segmentType.name}'] = DateTime.now();
    notifyListeners();
  }

  // finish tracking a segment and calculate time
  Future<void> finishSegmentTracking(
    String participantId,
    SegmentType segmentType,
  ) async {
    final startTime =
        _segmentStartTimes['${participantId}_${segmentType.name}'];
    if (startTime == null) return;

    final timeInSeconds = DateTime.now().difference(startTime).inSeconds;
    _segmentTimes['${participantId}_${segmentType.name}'] = timeInSeconds;

    // Remove the start time after finishing
    _segmentStartTimes.remove('${participantId}_${segmentType.name}');

    await repository.finishSegment(participantId, segmentType, timeInSeconds);
    notifyListeners();
  }

  // get the tracked time for a specific segment
  int getSegmentTime(String participantId, SegmentType segmentType) {
    return _segmentTimes['${participantId}_${segmentType.name}'] ?? 0;
  }

  // check if a segment is being tracked
  bool isTracked(String participantId, SegmentType segmentType) {
    return _segmentStartTimes.containsKey(
      '${participantId}_${segmentType.name}',
    );
  }

  Segment? getTrackedSegment(String participantId, SegmentType segmentType) {
    final timeInSeconds = _segmentTimes['${participantId}_${segmentType.name}'];
    if (timeInSeconds != null) {
      return Segment(type: segmentType, timeInSeconds: timeInSeconds);
    }
    return null; // If the segment hasn't been tracked yet
  }

  Future<void> resetTracking() async {
    _segmentStartTimes.clear();
    _segmentTimes.clear();
    await repository.resetTracking();
    notifyListeners();
  }
}

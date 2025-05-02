import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/repository/segment_tracking_repository.dart';

class SegmentTrackingProvider with ChangeNotifier {
  final SegmentTrackingRepository repository;
  late Stopwatch _stopwatch;
  late Ticker _ticker;

  SegmentTrackingProvider({required this.repository}) {
    _stopwatch = Stopwatch();
    _ticker = Ticker(_onTick);
  }

  List<Segment> get trackedSegments => repository.getSegments();

  // Track time for a specific segment
  Future<void> trackSegment(SegmentType segmentType) async {
    await repository.trackSegment(segmentType);
    _stopwatch.start();
    _ticker.start();
    notifyListeners();
  }

  // Untrack a segment if there was a mistake
  Future<void> untrackSegment(SegmentType segmentType) async {
    await repository.untrackSegment(segmentType);
    _stopwatch.stop();
    _ticker.stop();
    notifyListeners();
  }

  // Finish the segment
  Future<void> finishSegment(SegmentType segmentType) async {
    await repository.finishSegment(segmentType);
    _stopwatch.stop();
    _ticker.stop();
    notifyListeners();
  }

  // Reset the tracking for all segments
  Future<void> resetTracking() async {
    await repository.resetTracking();
    _stopwatch.stop();
    _stopwatch.reset();
    _ticker.stop();
    notifyListeners();
  }

  // Called every tick to update the segment time
  void _onTick(Duration elapsed) {
    if (!_stopwatch.isRunning) return;

    for (var segment in trackedSegments) {
      if (segment.isTracked) {
        segment.timeInSeconds = _stopwatch.elapsed.inSeconds;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}

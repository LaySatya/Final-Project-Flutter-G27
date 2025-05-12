import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';

import '../models/race.dart';
import '../models/segment.dart';

class RaceProvider with ChangeNotifier {
  late Race _race;
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  // getter to get the status of race
  bool get isRaceNotStarted => _race.status == RaceStatus.notStarted;
  bool get isRaceOngoing => _race.status == RaceStatus.ongoing;
  bool get isRaceFinished => _race.status == RaceStatus.finished;

  RaceProvider() {
    _race = Race(
      name: 'Race',
      dateTime: DateTime.now(),
      status: RaceStatus.notStarted,
      elapsedTime: 0,
      segments: [
        Segment(type: SegmentType.swim),
        Segment(type: SegmentType.cycle),
        Segment(type: SegmentType.run),
      ],
    );
    _stopwatch = Stopwatch();
    _ticker = Ticker(_onTick);
  }

  Race get race => _race;

  // start race
  void startRace(BuildContext context) {
    _race.status = RaceStatus.ongoing;
    _stopwatch.start();
    _ticker.start();

    final participantProvider = Provider.of<ParticipantProvider>(
      context,
      listen: false,
    );
    final segmentTrackingProvider = Provider.of<SegmentTrackingProvider>(
      context,
      listen: false,
    );

    // start auto to track all the participants
    for (var segment in _race.segments) {
      for (var participant in participantProvider.participants) {
        segmentTrackingProvider.startSegmentTracking(
          participant.id,
          segment.type,
        );
      }
    }

    notifyListeners();
  }

  // stop race
  void stopRace() {
    _race.status = RaceStatus.finished;
    _stopwatch.stop();
    _ticker.stop();
    notifyListeners();
  }

  // reset race
  void resetRace() {
    _stopwatch.stop();
    _stopwatch.reset();
    _ticker.stop();
    _race = Race(
      name: 'Race 1',
      dateTime: DateTime.now(),
      status: RaceStatus.notStarted,
      elapsedTime: 0,
      segments: [
        Segment(type: SegmentType.swim),
        Segment(type: SegmentType.cycle),
        Segment(type: SegmentType.run),
      ],
    );

    notifyListeners();
  }

  void _onTick(Duration elapsed) {
    if (_race.status == RaceStatus.ongoing) {
      _race.elapsedTime = _stopwatch.elapsed.inSeconds;
      notifyListeners();
    }
  }
}

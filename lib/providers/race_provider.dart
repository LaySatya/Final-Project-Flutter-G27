import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/race.dart';
import '../models/segment.dart';

class RaceProvider with ChangeNotifier {
  late Race _race;
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

   bool get isRaceNotStarted => _race.status == RaceStatus.notStarted;
  bool get isRaceOngoing => _race.status == RaceStatus.ongoing;
  bool get isRaceFinished => _race.status == RaceStatus.finished;

  RaceProvider() {
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
    _stopwatch = Stopwatch();
    _ticker = Ticker(_onTick);
  }

  Race get race => _race;

  void startRace() {
    _race.status = RaceStatus.ongoing;
    _stopwatch.start();
    _ticker.start();
    notifyListeners();
  }

  void stopRace() {
    _race.status = RaceStatus.finished;
    _stopwatch.stop();
    _ticker.stop();
    notifyListeners();
  }

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

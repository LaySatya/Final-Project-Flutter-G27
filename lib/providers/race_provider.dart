import 'package:flutter/material.dart';
import '../models/race.dart';

class RaceProvider with ChangeNotifier {
  Race _race = Race(status: RaceStatus.notStarted, elapsedTime: 0);
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  RaceProvider() {
    _stopwatch = Stopwatch();
    _ticker = Ticker(_onTick);
  }

  Race get race => _race;

  bool get isRaceOngoing => _race.status == RaceStatus.ongoing;
  bool get isRaceNotStarted => _race.status == RaceStatus.notStarted;
  bool get isRaceFinished => _race.status == RaceStatus.finished;

  /// Start the race
  void startRace() {
    _race.status = RaceStatus.ongoing;
    _stopwatch.start();
    _ticker.start();
    notifyListeners();
  }

  /// Stop the race
  void stopRace() {
    _race.status = RaceStatus.finished;
    _stopwatch.stop();
    _ticker.stop();
    notifyListeners();
  }

  /// Reset the race
  void resetRace() {
    _race.status = RaceStatus.notStarted;
    _stopwatch.reset();
    _race.elapsedTime = 0;
    _ticker.stop();
    notifyListeners();
  }

  void _onTick(Duration elapsed) {
    _race.elapsedTime = _stopwatch.elapsed.inSeconds;
    notifyListeners();
  }

  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}

/// Simple Ticker class (if you don't use flutter_hooks or any extra packages)
class Ticker {
  final void Function(Duration elapsed) onTick;
  late final Stopwatch _stopwatch;
  late final Duration _interval;
  late bool _isActive;

  Ticker(this.onTick) {
    _stopwatch = Stopwatch();
    _interval = const Duration(seconds: 1);
    _isActive = false;
  }

  void start() {
    if (_isActive) return;
    _isActive = true;
    _stopwatch.start();
    _tick();
  }

  void stop() {
    _isActive = false;
    _stopwatch.stop();
  }

  void _tick() async {
    while (_isActive) {
      await Future.delayed(_interval);
      onTick(_stopwatch.elapsed);
    }
  }

  void dispose() {
    _isActive = false;
  }
}

enum RaceStatus { notStarted, ongoing, finished }

class Race {
  RaceStatus status;
  int elapsedTime; // in seconds

  Race({
    required this.status,
    required this.elapsedTime,
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class RaceControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final participantProvider = Provider.of<ParticipantProvider>(context, listen: false);
    final race = raceProvider.race;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Race Control', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          if (raceProvider.isRaceFinished)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                raceProvider.resetRace();                    // Reset race time
                participantProvider.resetParticipants();     // Reset all segment times
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Race and all participant times have been reset!')),
                );
              },
              tooltip: 'Reset Race',
            ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display Race Status with modern styling and icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    raceProvider.isRaceNotStarted
                        ? Icons.play_arrow
                        : raceProvider.isRaceOngoing
                            ? Icons.timer
                            : Icons.check_circle,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    raceProvider.isRaceNotStarted
                        ? 'Race not started yet'
                        : raceProvider.isRaceOngoing
                            ? 'Race ongoing'
                            : 'Race finished!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Display formatted time in large, bold font
              Text(
                formatTime(race.elapsedTime),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              // Buttons with modern design
              if (raceProvider.isRaceNotStarted)
                ElevatedButton(
                  onPressed: () {
                    raceProvider.startRace();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              else if (raceProvider.isRaceOngoing)
                ElevatedButton(
                  onPressed: () {
                    raceProvider.stopRace();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'STOP',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

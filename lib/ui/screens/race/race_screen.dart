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
        title: const Text('Race Control'),
        actions: [
          if (raceProvider.isRaceFinished)
            IconButton(
              icon: const Icon(Icons.refresh),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              raceProvider.isRaceNotStarted
                  ? 'Race not started yet'
                  : raceProvider.isRaceOngoing
                      ? 'Race ongoing'
                      : 'Race finished!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),

            // Display formatted time
            Text(
              formatTime(race.elapsedTime),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            if (raceProvider.isRaceNotStarted)
              ElevatedButton(
                onPressed: () {
                  raceProvider.startRace();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text('START', style: TextStyle(fontSize: 24)),
              )
            else if (raceProvider.isRaceOngoing)
              ElevatedButton(
                onPressed: () {
                  raceProvider.stopRace();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text('STOP', style: TextStyle(fontSize: 24)),
              ),
          ],
        ),
      ),
    );
  }
}

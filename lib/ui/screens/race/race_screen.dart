import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart'; // Make sure path matches!

class RaceControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final race = raceProvider.race;

    String formatTime(int elapsedSeconds) {
      final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
      final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
      return "$minutes:$seconds";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Race Control'),
        actions: [
          if (raceProvider.isRaceFinished)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                raceProvider.resetRace();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All participant times have been cleared!')),
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
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              formatTime(race.elapsedTime),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            if (raceProvider.isRaceNotStarted)
              ElevatedButton(
                onPressed: () {
                  raceProvider.startRace();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: Text('START', style: TextStyle(fontSize: 24)),
              )
            else if (raceProvider.isRaceOngoing)
              ElevatedButton(
                onPressed: () {
                  raceProvider.stopRace();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: Text('STOP', style: TextStyle(fontSize: 24)),
              ),
          ],
        ),
      ),
    );
  }
}

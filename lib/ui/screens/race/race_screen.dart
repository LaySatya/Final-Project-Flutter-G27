import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';

class RaceControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final participantProvider = Provider.of<ParticipantProvider>(
      context,
      listen: false,
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Race Control',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        // centerTitle: true,
        actions: [
          if (raceProvider.isRaceFinished)
            IconButton(
              icon: const Icon(Icons.restart_alt),
              onPressed:
                  () => _showResetConfirmationDialog(
                    context,
                    raceProvider,
                    participantProvider,
                  ),
              tooltip: 'Reset Race',
            ),
        ],
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primaryContainer.withOpacity(0.3),
              theme.colorScheme.secondaryContainer.withOpacity(0.1),
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Race Status Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          raceProvider.isRaceNotStarted
                              ? Icons.flag_outlined
                              : raceProvider.isRaceOngoing
                              ? Icons.directions_run
                              : Icons.flag_circle_outlined,
                          size: 32,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          raceProvider.isRaceNotStarted
                              ? 'READY TO START'
                              : raceProvider.isRaceOngoing
                              ? 'RACE IN PROGRESS'
                              : 'RACE COMPLETED',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Timer Display
                RaceTopBar(formatElapsedTime: formatElapsedTime),
                const SizedBox(height: 40),

                // Control Buttons
                if (raceProvider.isRaceNotStarted)
                  _buildActionButton(
                    context: context,
                    icon: Icons.play_arrow,
                    label: 'START RACE',
                    color: Colors.green,
                    onPressed: () => raceProvider.startRace(context),
                  )
                else if (raceProvider.isRaceOngoing)
                  _buildActionButton(
                    context: context,
                    icon: Icons.stop,
                    label: 'FINISH RACE',
                    color: Colors.redAccent,
                    onPressed: () => raceProvider.stopRace(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: color.withOpacity(0.3),
        ),
      ),
    );
  }

  Future<void> _showResetConfirmationDialog(
    BuildContext context,
    RaceProvider raceProvider,
    ParticipantProvider participantProvider,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Race?'),
          content: const Text(
            'This will reset all race times and participant data. Continue?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Reset', style: TextStyle(color: Colors.red)),
              onPressed: () {
                raceProvider.resetRace();
                participantProvider.resetAllParticipants();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Race and all participants have been reset',
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

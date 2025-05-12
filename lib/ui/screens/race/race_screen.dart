import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/screens/race/widgets/race_action_button.dart';
import 'package:race_tracking_app/ui/screens/race/widgets/race_status_card.dart';
import 'package:race_tracking_app/ui/screens/race/widgets/reset_confirmation_dialog.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class RaceControlScreen extends StatelessWidget {
  const RaceControlScreen({super.key});

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
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Race Control',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        // centerTitle: true,
        actions: [
          if (raceProvider.isRaceFinished)
            IconButton(
              icon: const Icon(Icons.restart_alt),
              onPressed:
                  () => showResetConfirmationDialog(
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
                RaceStatusCard(raceProvider: raceProvider),
                const SizedBox(height: 40),
                const RaceTopBar(formatElapsedTime: formatElapsedTime),
                const SizedBox(height: 40),
                if (raceProvider.isRaceNotStarted)
                  RaceActionButton(
                    icon: Icons.play_arrow,
                    label: 'START RACE',
                    color: Colors.green,
                    onPressed: () => raceProvider.startRace(context),
                  )
                else if (raceProvider.isRaceOngoing)
                  RaceActionButton(
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
}

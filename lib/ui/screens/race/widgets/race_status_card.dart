import 'package:flutter/material.dart';
import 'package:race_tracking_app/providers/race_provider.dart';

class RaceStatusCard extends StatelessWidget {
  final RaceProvider raceProvider;

  const RaceStatusCard({super.key, required this.raceProvider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getStatusIcon(), size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Text(
              _getStatusText(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon() {
    if (raceProvider.isRaceNotStarted) return Icons.flag_outlined;
    if (raceProvider.isRaceOngoing) return Icons.directions_run;
    return Icons.flag_circle_outlined;
  }

  String _getStatusText() {
    if (raceProvider.isRaceNotStarted) return 'READY TO START';
    if (raceProvider.isRaceOngoing) return 'RACE IN PROGRESS';
    return 'RACE COMPLETED';
  }
}

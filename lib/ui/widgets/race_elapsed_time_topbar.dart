import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class RaceTopBar extends StatefulWidget {
  final String Function(int seconds) formatElapsedTime;

  const RaceTopBar({Key? key, required this.formatElapsedTime})
    : super(key: key);

  @override
  _RaceTopBarState createState() => _RaceTopBarState();
}

class _RaceTopBarState extends State<RaceTopBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _lastElapsedTime = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    _animationController.forward(from: 0.0).then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final elapsedTime = raceProvider.race.elapsedTime;
    final theme = Theme.of(context);

    if (elapsedTime != _lastElapsedTime) {
      _lastElapsedTime = elapsedTime;
      _triggerAnimation();
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time Display
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.formatElapsedTime(elapsedTime),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),

          // Status Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getStatusColor(raceProvider, theme).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getStatusColor(raceProvider, theme),
                width: 1.5,
              ),
            ),
            child: Text(
              raceProvider.isRaceNotStarted
                  ? "NOT STARTED"
                  : raceProvider.isRaceOngoing
                  ? "ON GOING"
                  : "FINISHED",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: _getStatusColor(raceProvider, theme),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(RaceProvider raceProvider, ThemeData theme) {
    return raceProvider.isRaceNotStarted
        ? theme.colorScheme.onSurface.withOpacity(0.6)
        : raceProvider.isRaceOngoing
        ? Colors.green
        : Colors.red;
  }
}

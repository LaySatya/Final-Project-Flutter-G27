import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/race_provider.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class RaceTopBar extends StatefulWidget {
  final String Function(int seconds) formatElapsedTime;

  const RaceTopBar({
    Key? key,
    required this.formatElapsedTime,
  }) : super(key: key);

  @override
  _RaceTopBarState createState() => _RaceTopBarState();
}

class _RaceTopBarState extends State<RaceTopBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _lastElapsedTime = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 1.2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    _controller.forward(from: 0.0).then((_) {
      _controller.reverse();
    });
  }

 

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final elapsedTime = raceProvider.race.elapsedTime;

    // If elapsedTime changes, trigger animation
    if (elapsedTime != _lastElapsedTime) {
      _lastElapsedTime = elapsedTime;
      _triggerAnimation();
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              formatTime(elapsedTime),  // Use the formatTime method to show hours, minutes, and seconds
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            raceProvider.isRaceNotStarted
                ? "NOT STARTED"
                : raceProvider.isRaceOngoing
                    ? "ON GOING"
                    : "FINISHED",
            style: TextStyle(
              color: raceProvider.isRaceFinished ? Colors.red : Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

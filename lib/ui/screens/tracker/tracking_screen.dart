import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/race_provider.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/participant_bib_grid.dart';

import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_tap.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  SegmentType _currentSegment = SegmentType.swim;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Participant Tracking',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            tooltip: 'Refresh Participants',
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: _confirmResetTracking,
            tooltip: 'Reset All Tracking',
          ),
        ],
      ),
      body: Column(
        children: [
          const RaceTopBar(formatElapsedTime: formatElapsedTime),
          SegmentTabs(
            currentSegment: _currentSegment,
            onSegmentChanged: _changeSegment,
          ),
          Expanded(child: _buildTrackingContent()),
        ],
      ),
    );
  }

  Widget _buildTrackingContent() {
    return Consumer3<
      ParticipantProvider,
      SegmentTrackingProvider,
      RaceProvider
    >(
      builder: (
        context,
        participantProvider,
        trackingProvider,
        raceProvider,
        _,
      ) {
        if (participantProvider.participants.isEmpty) {
          return const Center(
            child: Text('No participants available for tracking'),
          );
        }

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ParticipantGrid(
          currentSegment: _currentSegment,
          formatElapsedTime: formatElapsedTime,
          onBibTap:
              (participant) =>
                  _handleBibTap(participant, trackingProvider, raceProvider),
        );
      },
    );
  }

  Future<void> _handleBibTap(
    Participant participant,
    SegmentTrackingProvider trackingProvider,
    RaceProvider raceProvider,
  ) async {
    if (!raceProvider.isRaceOngoing) {
      _showSnackBar('Race must be ongoing to track participants');
      return;
    }

    final isTracked = trackingProvider.isTracked(
      participant.id,
      _currentSegment,
    );

    try {
      if (isTracked) {
        await trackingProvider.finishSegmentTracking(
          participant.id,
          _currentSegment,
        );
        _showSnackBar(
          'Finished ${_currentSegment.name} for ${participant.bib}',
        );
      } else {
        _showSnackBar('Already being tracked automatically');
      }
    } catch (e) {
      _showSnackBar('Error tracking participant: ${e.toString()}');
    }
  }

  void _changeSegment(SegmentType segment) {
    setState(() {
      _currentSegment = segment;
    });
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final participantProvider = Provider.of<ParticipantProvider>(
        context,
        listen: false,
      );
      await participantProvider.loadParticipants();
    } catch (e) {
      _showSnackBar('Error refreshing data: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _confirmResetTracking() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Reset All Tracking?'),
            content: const Text(
              'This will clear ALL segment tracking data for ALL participants.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Reset All'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        final trackingProvider = Provider.of<SegmentTrackingProvider>(
          context,
          listen: false,
        );
        await trackingProvider.resetTracking();
        _showSnackBar('All tracking data has been reset');
      } catch (e) {
        _showSnackBar('Error resetting tracking: ${e.toString()}');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

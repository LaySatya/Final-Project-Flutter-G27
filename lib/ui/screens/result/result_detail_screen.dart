import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/segment_time_card.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/total_time_card.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';

class ResultDetailScreen extends StatelessWidget {
  final Participant participant;

  const ResultDetailScreen({Key? key, required this.participant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),

            // Segment cards
            ...SegmentType.values.map((segment) {
              final timeInSeconds = participant.segments[segment]?.timeInSeconds ?? 0;
              final timeText = timeInSeconds > 0 ? formatTime(timeInSeconds) : '--';

              return SegmentTimeCard(
                segment: segment,
                time: timeText,
              );
            }),

            const SizedBox(height: 24),

            // Total time card
            TotalTimeCard(totalTime: formatTime(participant.totalTime)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          participant.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'BIB: ${participant.bib}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

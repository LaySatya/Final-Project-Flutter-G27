import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';
import 'package:race_tracking_app/providers/segment_tracking_provider.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/result_list.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/result_summary_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final trackingProvider = Provider.of<SegmentTrackingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Race Results',
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          ResultsSummaryCard(
            participants: participantProvider.participants,
            trackingProvider: trackingProvider,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ResultsList(
              participants: participantProvider.participants,
              trackingProvider: trackingProvider,
            ),
          ),
        ],
      ),
    );
  }
}

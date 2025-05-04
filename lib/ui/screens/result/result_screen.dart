import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/animation_participant_tile.dart';
import 'package:race_tracking_app/ui/screens/result/widgets/header_text.dart';
import 'package:race_tracking_app/ui/utils/time_utils.dart';
import 'package:race_tracking_app/ui/widgets/race_elapsed_time_topbar.dart';

import '../../../models/participant.dart';
import '../../../providers/participant_provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final participants = Provider.of<ParticipantProvider>(context).participants;

    // Sort by total time - sum time of all segments
    final sortedParticipants = List<Participant>.from(participants)
      ..sort((a, b) {
        final aTime = a.totalTime;
        final bTime = b.totalTime;
        return aTime.compareTo(bTime);
      });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Race Results',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            // onPressed: () => _exportResults(context, sortedParticipants),
            onPressed: () => null,
            tooltip: 'Export/Share Results',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Timer Bar
            RaceTopBar(formatElapsedTime: formatElapsedTime),

            const SizedBox(height: 16),

            // Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  HeaderText('RANK', flex: 2),
                  HeaderText('BIB', flex: 2),
                  HeaderText('NAME', flex: 4),
                  HeaderText('TIME', flex: 3),
                  HeaderText('DETAIL', flex: 0),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Participant List with Cards
            Expanded(
              child: ListView.builder(
                itemCount: sortedParticipants.length,
                itemBuilder: (context, index) {
                  final participant = sortedParticipants[index];
                  final time = participant.totalTime;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AnimatedParticipantTile(
                      rank: index + 1,
                      participant: participant,
                      formattedTime: time > 0 ? formatTime(time) : '--',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          icon: Icon(Icons.download, color: Colors.white),
          label: Text('Export Results', style: TextStyle(color: Colors.white)),
          // onPressed: () => _exportResults(context, sortedParticipants),
          onPressed: () => null,
        ),
      ),
    );
  }

  // Future<void> _exportResults(BuildContext context, List<Participant> participants) async {
  //   final buffer = StringBuffer();
  //   buffer.writeln('Rank,BIB,Name,Total Time (s)');

  //   final sorted = List<Participant>.from(participants)
  //     ..sort((a, b) => a.totalTime.compareTo(b.totalTime));

  //   for (int i = 0; i < sorted.length; i++) {
  //     final p = sorted[i];
  //     buffer.writeln('${i + 1},${p.bib},${p.name},${p.totalTime}');
  //   }

  //   try {
  //     final dir = await getTemporaryDirectory();
  //     final file = File('${dir.path}/race_results.csv');
  //     await file.writeAsString(buffer.toString());

  //     await Share.shareXFiles([XFile(file.path)], text: 'Race Results');
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Export failed: $e')),
  //     );
  //   }
  // }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app/models/participant.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/providers/participant_provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final participants = Provider.of<ParticipantProvider>(context).participants;

    // Sort by total time (keeping your existing logic)
    final sortedParticipants = List<Participant>.from(participants)
      ..sort((a, b) => a.totalTime.compareTo(b.totalTime));

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Race Results',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () => _showExportOptions(context),
            tooltip: 'Share Results',
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem(
                      context,
                      'Participants',
                      participants.length.toString(),
                    ),
                    _buildSummaryItem(
                      context,
                      'Fastest',
                      _formatTime(sortedParticipants.first.totalTime),
                    ),
                    _buildSummaryItem(
                      context,
                      'Avg Time',
                      _formatTime(_calculateAverageTime(sortedParticipants)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Results List Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(color: theme.dividerColor, width: 1),
              ),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    'Rank',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Text(
                    'BIB',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: sortedParticipants.length,
              itemBuilder: (context, index) {
                final participant = sortedParticipants[index];
                final isTopThree = index < 3;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap:
                          () => _showParticipantDetails(context, participant),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            // Rank Badge
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color:
                                    isTopThree
                                        ? [
                                          Colors.amber,
                                          Colors.grey,
                                          Colors.brown,
                                        ][index].withOpacity(0.2)
                                        : theme.colorScheme.surfaceVariant
                                            .withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isTopThree
                                            ? [
                                              Colors.amber,
                                              Colors.grey,
                                              Colors.brown,
                                            ][index]
                                            : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // BIB
                            Expanded(
                              flex: 2,
                              child: Text(
                                participant.bib,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Name
                            Expanded(
                              flex: 3,
                              child: Text(
                                participant.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Time
                            Expanded(
                              flex: 2,
                              child: Text(
                                _formatTime(participant.totalTime),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),

                            // Details chevron
                            Icon(
                              Icons.chevron_right,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: const Icon(Icons.download, color: Colors.white),
      //   label: const Text('Export', style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.deepPurple,
      //   onPressed: () => _showExportOptions(context),
      // ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Keep your existing formatTime function as is
  String _formatTime(int seconds) {
    // Your existing implementation
    return ''; // Replace with your actual function
  }

  int _calculateAverageTime(List<Participant> participants) {
    if (participants.isEmpty) return 0;
    final total = participants.fold(0, (sum, p) => sum + p.totalTime);
    return total ~/ participants.length;
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export Results',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('PDF Document'),
                onTap: () {
                  Navigator.pop(context);
                  // Your PDF export logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_chart),
                title: const Text('CSV Spreadsheet'),
                onTap: () {
                  Navigator.pop(context);
                  // Your CSV export logic
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showParticipantDetails(BuildContext context, Participant participant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${participant.bib} - ${participant.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSegmentTime(
                'Swim',
                participant.segments[SegmentType.swim]?.timeInSeconds ?? 0,
              ),
              _buildSegmentTime(
                'Cycle',
                participant.segments[SegmentType.cycle]?.timeInSeconds ?? 0,
              ),
              _buildSegmentTime(
                'Run',
                participant.segments[SegmentType.run]?.timeInSeconds ?? 0,
              ),
              const SizedBox(height: 16),
              Text(
                'Total: ${_formatTime(participant.totalTime)}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSegmentTime(String segment, int time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(segment, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(_formatTime(time)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/segment.dart';

class SegmentTimeCard extends StatelessWidget {
  final SegmentType segment;
  final String time;

  const SegmentTimeCard({super.key, required this.segment, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(_segmentIcon(segment), color: Colors.blue.shade600),
        title: Text(segment.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(time, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  IconData _segmentIcon(SegmentType segment) {
    switch (segment) {
      case SegmentType.swim:
        return Icons.pool;
      case SegmentType.cycle:
        return Icons.directions_bike;
      case SegmentType.run:
        return Icons.directions_run;
    }
  }
}

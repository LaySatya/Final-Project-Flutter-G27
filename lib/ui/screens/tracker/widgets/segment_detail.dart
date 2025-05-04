import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/segment.dart';

class SegmentDetail extends StatelessWidget {
  final SegmentType segment;

  const SegmentDetail({required this.segment});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String label;

    // Determine icon and label based on the selected segment
    switch (segment) {
      case SegmentType.swim:
        icon = Icons.pool;
        label = 'SWIM';
        break;
      case SegmentType.cycle:
        icon = Icons.directions_bike;
        label = 'CYCLE';
        break;
      case SegmentType.run:
        icon = Icons.directions_run;
        label = 'RUN';
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.deepPurple, size: 24), 
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 16, 
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}

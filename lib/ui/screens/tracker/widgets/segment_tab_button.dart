import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/segment.dart';

class SegmentTabButton extends StatelessWidget {
  final SegmentType segmentType;
  final SegmentType currentSegment;
  final String label;
  final VoidCallback onTap;

  const SegmentTabButton({
    Key? key,
    required this.segmentType,
    required this.currentSegment,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentSegment == segmentType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          backgroundColor: isSelected ? Colors.blue.shade100 : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.blue : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

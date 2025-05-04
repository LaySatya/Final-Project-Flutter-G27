import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_tab_button.dart';

class SegmentTabs extends StatelessWidget {
  final SegmentType currentSegment;
  final ValueChanged<SegmentType> onSegmentChanged;

  const SegmentTabs({
    required this.currentSegment,
    required this.onSegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Swim Tab
          SegmentTabButton(
            segmentType: SegmentType.swim,
            currentSegment: currentSegment,
            label: "SWIM",
            onTap: () => onSegmentChanged(SegmentType.swim),
          ),
          // Cycle Tab
          SegmentTabButton(
            segmentType: SegmentType.cycle,
            currentSegment: currentSegment,
            label: "CYCLE",
            onTap: () => onSegmentChanged(SegmentType.cycle),
          ),
          // Run Tab
          SegmentTabButton(
            segmentType: SegmentType.run,
            currentSegment: currentSegment,
            label: "RUN",
            onTap: () => onSegmentChanged(SegmentType.run),
          ),
        ],
      ),
    );
  }
}

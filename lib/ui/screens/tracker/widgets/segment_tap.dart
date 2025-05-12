import 'package:flutter/material.dart';
import 'package:race_tracking_app/models/segment.dart';
import 'package:race_tracking_app/ui/screens/tracker/widgets/segment_tab_button.dart';

class SegmentTabs extends StatelessWidget {
  final SegmentType currentSegment;
  final ValueChanged<SegmentType> onSegmentChanged;

  const SegmentTabs({
    required this.currentSegment,
    required this.onSegmentChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Swim Tab
            _buildSegmentTab(context, SegmentType.swim, "SWIM", Icons.pool),
            // Cycle Tab
            _buildSegmentTab(
              context,
              SegmentType.cycle,
              "CYCLE",
              Icons.pedal_bike,
            ),
            // Run Tab
            _buildSegmentTab(
              context,
              SegmentType.run,
              "RUN",
              Icons.directions_run,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentTab(
    BuildContext context,
    SegmentType segmentType,
    String label,
    IconData icon,
  ) {
    final isSelected = currentSegment == segmentType;
    final theme = Theme.of(context);

    return Flexible(
      child: GestureDetector(
        onTap: () => onSegmentChanged(segmentType),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color:
                    isSelected
                        ? Colors.white
                        : theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

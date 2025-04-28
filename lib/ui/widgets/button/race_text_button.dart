import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Text Button rendering for the whole application
class RaceTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const RaceTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Render the button with full width
    return SizedBox(
      width: double.infinity, // Full width of the screen
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.0), // Add padding for a better look
            decoration: BoxDecoration(
              color: RaceTrackingColors.primary,
              borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
            ),
            child: Text(
              text,
              style: RaceTrackingTextStyles.button.copyWith(
                color: RaceTrackingColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

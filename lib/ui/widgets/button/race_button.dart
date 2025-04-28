import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

///
/// Button rendering for the whole application
///
class RaceButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const RaceButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.type = ButtonType.primary,
      this.icon});

  @override
  Widget build(BuildContext context) {
    // Compute the rendering
    Color backgroundColor =
        type == ButtonType.primary ? RaceTrackingColors.primary : RaceTrackingColors.white;

    BorderSide border = type == ButtonType.primary
        ? BorderSide.none
        : BorderSide(color: RaceTrackingColors.greyLight, width: 2);

    Color textColor =
        type == ButtonType.primary ? RaceTrackingColors.white : RaceTrackingColors.primary;

    Color iconColor =
        type == ButtonType.primary ? RaceTrackingColors.white : RaceTrackingColors.primary;

    // Create the button icon - if any
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(
        icon,
        size: 20,
        color: iconColor,
      ));
      children.add(SizedBox(width: RaceTrackingSpacings.s));
    }

    // Create the button text
    Text buttonText =
        Text(text, style: RaceTrackingTextStyles.button.copyWith(color: textColor));

    children.add(buttonText);

    // Render the button
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RaceTrackingSpacings.radius),
          ),
          side: border,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

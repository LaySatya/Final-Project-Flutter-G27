import 'package:flutter/material.dart';

import '../../theme/theme.dart';

const String blablaWifiImagePath = 'assets/images/blabla_wifi.png';

class RaceError extends StatelessWidget {
  const RaceError({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: RaceTrackingSpacings.m, right: RaceTrackingSpacings.m, top: RaceTrackingSpacings.s),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              blablaWifiImagePath,
              fit: BoxFit.none, // Adjust image fit to cover the container
            ),
            Text(
              message,
              style: RaceTrackingTextStyles.heading.copyWith(color: RaceTrackingColors.textNormal),
            ),
          ],
        ),
      ),
    ));
  }
}

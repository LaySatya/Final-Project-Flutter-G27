import 'package:flutter/material.dart';

class TotalTimeCard extends StatelessWidget {
  final String totalTime;

  const TotalTimeCard({super.key, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(totalTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

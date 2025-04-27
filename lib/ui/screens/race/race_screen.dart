import 'package:flutter/material.dart';

class RaceControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Race Control')),
      body: Center(child: Text('Start and stop the race here')),
    );
  }
}

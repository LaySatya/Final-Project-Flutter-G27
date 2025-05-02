import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final int flex;

  const HeaderText(this.text, {super.key, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

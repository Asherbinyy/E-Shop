import 'package:flutter/material.dart';

/// The way tab bar item looks
class TabItem extends StatelessWidget {
  final double tabWidth;
  final double tabHeight;
  final String label;
  const TabItem(
    this.label, {
    Key? key,
    required this.tabWidth,
    required this.tabHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tabWidth,
      height: tabHeight,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: FittedBox(
          child: Text(label.toUpperCase()),
        ),
      ),
    );
  }
}




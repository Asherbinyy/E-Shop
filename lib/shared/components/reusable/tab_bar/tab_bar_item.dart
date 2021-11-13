import 'package:flutter/material.dart';
///reviewed

/// The way tab bar item looks
class TabItem extends StatelessWidget {
  final double tabHeight;
  final String label;
  const TabItem(
    this.label, {
    Key? key,
    required this.tabHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tabHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: FittedBox(
          child: Text(
            label.toUpperCase(),
            // style: TextStyle(color:AppCubit.get(context).isDark?Colors.white:Colors.amber),
          ),
        ),
      ),
    );
  }
}




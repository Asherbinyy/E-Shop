import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String label ;
  const CategoryScreen({Key? key,required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(label),
      ),
    );
  }
}

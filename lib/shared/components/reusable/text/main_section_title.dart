import 'package:flutter/material.dart';
import 'custom_text.dart';

class MainSectionTitle extends StatelessWidget {
  final String label;
  const MainSectionTitle(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: CustomText(
        label,
        fontSize: 18,
        isBold: true,
      ),
    );
  }
}

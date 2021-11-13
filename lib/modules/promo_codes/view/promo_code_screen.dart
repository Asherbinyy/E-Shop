import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';

class PromoCodeScreen extends StatelessWidget {
  const PromoCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('PromoCode'),
      child: Scaffold(
        appBar: SecondaryAppBar(title: 'PromoCode Screen'),
        body: Center(child: Text('PromoCode Screen')),
      ),
    );
  }
}

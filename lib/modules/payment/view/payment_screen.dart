import 'package:e_shop/shared/components/builders/comming_soon_builder.dart';

import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('Payment'),
      child: Scaffold(
        appBar: SecondaryAppBar(title: 'Payment Screen'),
        body: ComingSoonBuilder(
          child:  Column(
            children: const[],
          ),
        ),
      ),
    );
  }
}

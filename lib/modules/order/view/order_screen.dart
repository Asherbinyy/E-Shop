import 'package:e_shop/shared/components/builders/comming_soon_builder.dart';
import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'OrderScreen',),
      body: ComingSoonBuilder(
        child:const SizedBox(),
        /// Order screen should be here
      ),
    );
  }
}

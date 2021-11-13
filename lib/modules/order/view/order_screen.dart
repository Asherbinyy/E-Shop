import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'OrderScreen',),
      body: Hero(
        tag: 'OrderScreen',
        child: Column(
          children: [
            Text('OrderScreen'),
          ],
        ),
      ),
    );
  }
}

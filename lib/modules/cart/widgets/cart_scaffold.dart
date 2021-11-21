import 'package:e_shop/modules/cart/widgets/widgets_cart_imports.dart';
import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartScaffold extends StatelessWidget {
  final Widget child ;
  const CartScaffold({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
       const CartFooterBuilder()
      ],
      appBar: SecondaryAppBar(
        title: 'cart'.tr(),
        actions: [
          // const CartExpandCollapseButton(),
        ],
      ),
      body: child,
    );
  }
}

part of 'widgets_cart_imports.dart';

class CartExpandCollapseButton extends StatelessWidget {
  const CartExpandCollapseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        // ExpansionPanelList(children: [ExpansionPanel(headerBuilder: headerBuilder, body: body)],);
        return CustomTextButton.icon(
            icon:
              cubit.isExpandedCarts
                  ? FontAwesomeIcons.compressAlt
                  : Icons.expand,
            label: cubit.isExpandedCarts
                ? 'collapse_all'.tr()
                : 'expand_all'.tr(),
            onPressed: () => cubit.toggleExpandedCarts());
        // return CustomTextButton.icon(
        //     icon:
        //       cubit.isExpandedCarts
        //           ? FontAwesomeIcons.compressAlt
        //           : Icons.expand,
        //     label: cubit.isExpandedCarts
        //         ? 'collapse_all'.tr()
        //         : 'expand_all'.tr(),
        //     onPressed: () => cubit.toggleExpandedCarts());
      },
    );
  }
}

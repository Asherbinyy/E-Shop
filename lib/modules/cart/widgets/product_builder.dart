part of 'widgets_cart_imports.dart';

class ProductBuilder extends StatelessWidget {
  final HomeCubit cubit;
  final List<CartItems>? carts;
  final bool showSpinner;
  final bool isAllExpanded;
  const ProductBuilder(
      this.cubit,
      this.carts,
      this.showSpinner, {
        this.isAllExpanded = true,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Builder(
        builder: (context) {
          return Stack(
            children: [
              Opacity(
                opacity: showSpinner ? 0.3 : 1,
                child: ListView.builder(
                  physics:const BouncingScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: carts?.length,
                  itemBuilder: (context, index) {
                    CartItems? cart = carts?[index];
                    return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child:const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (dismissDirection) {
                          carts?.removeAt(index);
                          cubit.changeCarts(cart!.product!.id!);
                          cubit.getCarts();
                        },
                        child: ExpansionTile(
                          collapsedIconColor: kPrimaryColor,
                          initiallyExpanded: cubit.isExpandedCarts,
                          collapsedBackgroundColor: AppCubit.get(context).isDark
                              ? kDarkSecondaryColor
                              : kLightSecondaryColor,
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(cart!.product!.name!,
                                    style: Theme.of(context).textTheme.bodyText2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text('( x ${cart.quantity} )',
                                  style: Theme.of(context).textTheme.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            child: Text(
                              "${cart.product?.price} "+"egyptian_pound".tr()+" ( "+"per_piece".tr()+" )",
                              style: const TextStyle(color: kSecondaryColor),
                            ),
                          ),
                          children: [
                            SizedBox(
                              height: height * 0.25,
                              child: ProductCard(
                                isCartScreen: true,
                                isGrid: false,
                                name: cart.product!.name!,
                                quantity: cart.quantity,
                                // quantity: cubit.cartAmount[cart.id],
                                seller: 'e_shop'.tr(),
                                image: cart.product!.image!,
                                price: cart.product!.price!,
                                id: cart.product!.id!,
                                cartId: cart.id,
                                oldPrice: cart.product!.oldPrice!,
                                discount: cart.product!.discount!,
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
              if (showSpinner)const Center(
                child: kLoadingFadingCircle,
              ),
            ],
          );
        });
  }
}

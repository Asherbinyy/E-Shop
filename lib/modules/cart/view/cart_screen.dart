part of 'cart_imports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CartWrapper(
      screen: CartScaffold(
        child: BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            final cubit = LayoutCubit.get(context);
            final carts = cubit.getCartsModel?.data?.cartItems;
            return MyConditionalBuilder(
              condition: carts != null,
              onBuild: carts!.length > 0
                  ? CartBuilder(cubit, carts)
                  : const CartEmpty(),
              onError: const Center(child: kLoadingFadingCircle),
            );
          },
        ),
      ),
    );
  }
}
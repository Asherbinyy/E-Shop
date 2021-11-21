part of 'cart_imports.dart';

class CartWrapper extends StatelessWidget {
  final Widget screen;
  const CartWrapper({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: BlocListener<CartCubit, CartStates>(
        listener: (context, state) {},
        child: screen,
      ),
    );
  }
}

part of 'widgets_cart_imports.dart';

class CartFooterBuilder extends StatelessWidget {
  const CartFooterBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        final cubit = LayoutCubit.get(context);
        return MyConditionalBuilder(
          key: key,
          condition: cubit.getCartsModel?.data?.total != null,
          onBuild: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: CustomText(
                        'total'.tr() +
                            ' ${cubit.getCartsModel?.data?.total?.toStringAsFixed(1)} L.E'
                                .toUpperCase(),
                        color: Colors.white),
                  ),
                ),
              ),
              XSpace.normal,
              CustomTextButton(
                child: Hero(
                    tag: 'OrderScreen',
                    child: CustomText('make_order'.tr(),isUpperCase: true,)),
                onPressed: () => navigateTo(context, const OrderScreen()),
              ),
            ],
          ),
          onError: const SizedBox(),
        );
      },
    );
  }
}

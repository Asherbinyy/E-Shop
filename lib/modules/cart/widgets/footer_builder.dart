part of 'widgets_cart_imports.dart';
class FooterBuilder extends StatelessWidget {
  final HomeCubit cubit;
  const FooterBuilder(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Text(
                'total'.tr()+' ${cubit.getCartsModel?.data?.total?.toStringAsFixed(1)} L.E'
                    .toUpperCase(),
                style:const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        XSpace.normal,
        TextButton(
          style: OutlinedButton.styleFrom(onSurface: Colors.red),
          child: Hero(
              tag: 'OrderScreen',
              child: Text('make_order'.tr().toUpperCase())),
          onPressed: () => navigateTo(context,const OrderScreen()),
        ),
      ],
    );
  }
}

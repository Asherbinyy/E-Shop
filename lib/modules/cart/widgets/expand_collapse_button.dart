part of 'widgets_cart_imports.dart';


class ExpandCollapseButton extends StatelessWidget {
  const ExpandCollapseButton({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        icon: Icon(
          cubit.isExpandedCarts
              ? FontAwesomeIcons.compressAlt
              : Icons.expand,
        ),
        label:
        Text(cubit.isExpandedCarts ? 'collapse_all'.tr() : 'expand_all'.tr()),
        onPressed: () => cubit.toggleExpandedCarts());
  }
}

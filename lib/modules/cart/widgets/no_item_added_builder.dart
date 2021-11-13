part of 'widgets_cart_imports.dart';

class NoItemsAdded extends StatelessWidget {
  const NoItemsAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        physics:const BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(
            kEmptyCartLottie,
            repeat: false,
          ),
          YSpace.extreme,
          Center(
            child: Text(
              'empty_cart'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


part of 'widgets_custom_drawer_imports.dart';

class DrawerMenuOptions extends StatelessWidget {
  final LayoutCubit cubit;
  const DrawerMenuOptions(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: ValueKey<String>('Payment'),
              child: OptionListTile(
                label: 'payment'.tr(),
                icon: Icons.payment_outlined,
                onPressed: () => navigateTo(context, const PaymentScreen()),
              ),
            ),
            Hero(
              tag: ValueKey<String>('PromoCode'),
              child: OptionListTile(
                  label: 'promo_codes'.tr(),
                  icon: FontAwesomeIcons.gift,
                  onPressed: () =>
                      navigateTo(context, const PromoCodeScreen())),
            ),
            Hero(
                tag: ValueKey<String>('Notification'),
                child: OptionListTile(
                    label: 'notifications'.tr(),
                    icon: FontAwesomeIcons.bell,
                    onPressed: () =>
                        navigateTo(context, const NotificationScreen()))),
            Hero(
                tag: ValueKey<String>('FAQ'),
                child: OptionListTile(
                    label: 'faq'.tr(),
                    icon: FontAwesomeIcons.question,
                    onPressed: () => navigateTo(context, const FaqScreen()))),
            Hero(
              tag: ValueKey<String>('Contact_Us'),
              child: OptionListTile(
                label: 'contact_us'.tr(),
                icon: FontAwesomeIcons.lightbulb,
                onPressed: () => navigateTo(context, const ContactUsScreen()),
              ),
            ),
            Hero(
                tag: ValueKey<String>('RateUs'),
                child: OptionListTile(
                    label: 'rate_us'.tr(),
                    icon: FontAwesomeIcons.solidGrinStars,
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const RateUsDialog()))),
            OptionListTile(
                label: 'sign_out'.tr(),
                icon: Icons.logout,
                isBackgroundColor: true,
                onPressed: () => cubit.signOut()),
          ],
        ),
      ),
    );
  }
}

import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/modules/auth/login/view/login_imports.dart';
import 'package:e_shop/modules/faq/view/faq_imports.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/custom_divider.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/models/api/user/profile.dart';
import '../../../../modules/contact_us/view/contact_us_screen.dart';
import '../../../../modules/notification/view/notification_screen.dart';
import '../../../../modules/payment/view/payment_screen.dart';
import '../../../../modules/promo_codes/view/promo_code_screen.dart';
import '/shared/components/reusable/dialogue/rate_us_dialog.dart';
import '/shared/components/reusable/tiles/option_tile.dart';
import '../../../../modules/email_verification/view/email_verification_screen.dart';
import '../../../../modules/profile/view/profile_screen.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';

///reviewed
class CustomDrawerScreen extends StatelessWidget {
  const CustomDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          if (state.signOutModel.status!) {
            CacheHelper.removeData(TOKEN).then((value) {
              if (value) {
                navigateToAndFinish(context,const LoginScreen());
              }
            });
          } else {
            Utils.showSnackBar(context, state.signOutModel.message!,
                dialogueStates: DialogueStates.ERROR,
                isDark: AppCubit.get(context).isDark);
            navigateBack(context);
          }
        }
        if (state is SignOutErrorState) {
          navigateBack(context);
          Utils.showSnackBar(context, 'something_went_wrong'.tr(),
              dialogueStates: DialogueStates.ERROR,
              isDark: AppCubit.get(context).isDark);
        }
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        ProfileData? profile = cubit.profileModel?.data;

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Drawer(
            child: Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _ViewProfileWidget(profile: profile),
                      if (!cubit.isEmailVerified)
                        _VerifyMail(onTap: () => navigateTo(context,const EmailVerificationScreen())),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        child: XDivider.normal(),
                      ),
                      _MenuOptions(cubit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
class _VerifyMail extends StatelessWidget {
  final GestureTapCallback? onTap;
  const _VerifyMail({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.amber.withOpacity(0.1),
        child: InkWell(
            child: ListTile(
              onTap: onTap,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.info,
                color: Colors.amber,
              ),
              title: Text(
                'verify_email'.tr(),
                style: const TextStyle(color: Colors.amber),
              ),
            )),
      ),
    );
  }
}
class _ViewProfileWidget extends StatelessWidget {
  const _ViewProfileWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileData? profile;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        navigateTo(context,const ProfileScreen());
      },
      child: Row(
        children: [
          Hero(
            tag: ValueKey<String>('${profile?.id}'),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${profile?.image}'),
            ),
          ),
          XSpace.normal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile?.name?.toUpperCase()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  'view_your_account'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuOptions extends StatelessWidget {
  final LayoutCubit cubit;
  const _MenuOptions(this.cubit, {Key? key}) : super(key: key);

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
                onPressed: () => navigateTo(context,const PaymentScreen()),
              ),
            ),
            Hero(
              tag: ValueKey<String>('PromoCode'),
              child: OptionListTile(
                  label: 'promo_codes'.tr(),
                  icon: FontAwesomeIcons.gift,
                  onPressed: () => navigateTo(context,const PromoCodeScreen())),
            ),
            Hero(
                tag: ValueKey<String>('Notification'),
                child: OptionListTile(
                    label: 'notifications'.tr(),
                    icon: FontAwesomeIcons.bell,
                    onPressed: () =>
                        navigateTo(context,const NotificationScreen()))),
            Hero(
                tag: ValueKey<String>('FAQ'),
                child: OptionListTile(
                    label: 'faq'.tr(),
                    icon: FontAwesomeIcons.question,
                    onPressed: () => navigateTo(context,const FaqScreen()))),
            Hero(
              tag: ValueKey<String>('Contact_Us'),
              child: OptionListTile(
                label: 'contact_us'.tr(),
                icon: FontAwesomeIcons.lightbulb,
                onPressed: () => navigateTo(context,const ContactUsScreen()),
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

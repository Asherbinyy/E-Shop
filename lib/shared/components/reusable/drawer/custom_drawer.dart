import 'package:e_shop/modules/faq/faq_screen.dart';
import 'package:e_shop/modules/notification/notification_screen.dart';
import 'package:e_shop/modules/payment/payment_screen.dart';
import 'package:e_shop/modules/promo_codes/promo_code_screen.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/rate_us_dialog.dart';
import 'package:e_shop/styles/constants.dart';

import '/shared/components/reusable/tiles/expandable_tile.dart';
import '/shared/components/reusable/tiles/option_tile.dart';

import '../../../../models/api/user/profile.dart';
import '/modules/email_verification/email_verification_screen.dart';
import '/modules/login/login_screen.dart';
import '/modules/profile/profile_screen.dart';
import '/network/local/cache_helper.dart';
import '/network/local/cached_values.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CustomDrawerScreen extends StatelessWidget {
  const CustomDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          if (state.signOutModel.status!) {
            CacheHelper.removeData(TOKEN).then((value) {
              if (value) {
                navigateToAndFinish(context, LoginScreen());
              }
            });
          } else {
            DefaultDialogue.showSnackBar(context, state.signOutModel.message!,
                dialogueStates: DialogueStates.ERROR,
                isDark: AppCubit.get(context).isDark);
            Navigator.pop(context);
          }
        }
        if (state is SignOutErrorState) {
          Navigator.pop(context);
          DefaultDialogue.showSnackBar(context, 'Something went Wrong',
              dialogueStates: DialogueStates.ERROR,
              isDark: AppCubit.get(context).isDark);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
       ProfileData? profile =  cubit.profileModel?.data;


        return SizedBox(
          width: MediaQuery.of(context).size.width*0.7,

          child: Drawer(
            child: Scaffold(
              body: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _ViewProfileWidget(profile: profile),

                      if (! cubit.isEmailVerified)
                        _verifyMail(onTap: ()=>navigateTo(context, EmailVerificationScreen())),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
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

  Widget _verifyMail({final GestureTapCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.amber.withOpacity(0.1),
        child: InkWell(
            child: ListTile(
              onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.info,
            color: Colors.amber,
          ),
          title: Text(
            'You need to verify your email address',
            style: TextStyle(color: Colors.amber),
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
      onPressed: (){
        // Navigator.pop(context);
        navigateTo(context, ProfileScreen());
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
                  '${profile?.name?.toUpperCase()}',maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  'view_your_account',maxLines: 1,overflow: TextOverflow.ellipsis,
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
  final HomeCubit cubit;
  const _MenuOptions(this.cubit,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:MediaQuery.of(context).size.height*0.7 ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: ValueKey<String>('Payment'),
              child: OptionListTile(
                label: 'Payment',
                icon: Icons.payment_outlined,
                onPressed: () =>navigateTo(context, PaymentScreen()),
              ),
            ),
            Hero(
                tag: ValueKey<String>('PromoCode'),
                child: OptionListTile(
                    label: 'Promo Codes',
                    icon: FontAwesomeIcons.gift,
                    onPressed: () =>navigateTo(context, PromoCodeScreen())),
                ),
            Hero(
                tag: ValueKey<String>('Notification'),
                child: OptionListTile(label: 'Notification', icon: FontAwesomeIcons.bell,onPressed:()=>navigateTo(context, NotificationScreen()))),

            Hero(
                tag: ValueKey<String>('FAQ'),
                child: OptionListTile(label: 'FAQ',icon: FontAwesomeIcons.question, onPressed: ()=>navigateTo(context, FaqScreen()))),
            OptionListTile(label: 'About Us', icon: FontAwesomeIcons.lightbulb, onPressed: () =>DefaultDialogue.showMyAboutDialog(context)),

            Hero(
                tag: ValueKey<String>('RateUs'),
                child: OptionListTile(
                    label: 'Rate Us',
                    icon: FontAwesomeIcons.solidGrinStars,
                    onPressed: ()=>showDialog(context: context, builder: (context)=> RateUsDialog()))),

            OptionListTile(label: 'Sign Out', icon: Icons.logout,isBackgroundColor: true ,onPressed: () => cubit.signOut()),

          ],
        ),
      ),
    );
  }

// Row(
//   children: [
//
//     Icon(FontAwesomeIcons.globeAfrica,color: Theme.of(context).textTheme.bodyText2?.color,) ,
//     Text('Privacy',style: Theme.of(context).textTheme.bodyText2,),
//   ],
// ),
// Row(
//   children: [
//     Icon(FontAwesomeIcons.globeAfrica,color: Theme.of(context).textTheme.bodyText2?.color,) ,
//     Text('Privacy',style: Theme.of(context).textTheme.bodyText2,),
//   ],
// ),
// ExpandableListTile(label: 'dark_mode', icon: FontAwesomeIcons.solidMoon,
//     child: Center(
//   child: Switch.adaptive(
//       value: AppCubit.get(context).isDark,
//       onChanged: (newValue) {
//         // newValue = AppCubit.get(context).changeThemeModeViaSwitch();
//         Navigator.pop(context);
//       }),
// ), onPressed: () {}),
// OptionListTile(label: 'addresses', icon: Icons.location_on_sharp, onPressed: () {}),

  //     RoundedButton(
  //   label: 'log out',
  //   icon: Icons.logout,
  //   isIcon: true,
  //   color: isDark ? kPrimaryColorDarker : Colors.white,
  //   backgroundColor: isDark ? Colors.white : kPrimaryColorDarker,
  //   onPressed: () {
  //     cubit.signOut();
  //   },
  // );

}




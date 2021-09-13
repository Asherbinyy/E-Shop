import 'package:e_shop/modules/email_verification/email_verification_screen.dart';
import 'package:e_shop/modules/login/login_screen.dart';
import 'package:e_shop/network/local/cache_helper.dart';
import 'package:e_shop/network/local/cached_values.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';

import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
        return SafeArea(
          child: Drawer(
            child: Container(
              color: AppCubit.get(context).isDark
                  ? kDarkSecondaryColor
                  : kLightSecondaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('$kMoon'),
                            ),
                            XSpace.extreme,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sherbini',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 14),
                                ),
                                Text(
                                  'view_your_profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    if (cubit.isEmailVerified) _verifyMail(onTap: ()=>navigateTo(context, EmailVerificationScreen())),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: XDivider.normal(),
                      ),
                      _OptionalListTile(
                        label: 'settings',
                        icon: Icons.settings,
                        onPressed: () {},
                        // child: Column(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         XSpace(isWidth: true,num: 30,),
                        //         Icon(FontAwesomeIcons.globeAfrica,color: Theme.of(context).textTheme.bodyText2?.color,) ,
                        //         XSpace(isWidth: true,num: 10,),
                        //         Text('Privacy',style: Theme.of(context).textTheme.bodyText2,),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         XSpace(isWidth: true,num: 30,),
                        //         Icon(FontAwesomeIcons.globeAfrica,color: Theme.of(context).textTheme.bodyText2?.color,) ,
                        //         XSpace(isWidth: true,num: 10,),
                        //         Text('Privacy',style: Theme.of(context).textTheme.bodyText2,),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ),
                      YSpace.extreme,
                      _DrawerListTile(
                          label: 'appearance', icon: FontAwesomeIcons.palette),
                      YSpace.extreme,
                      _OptionalListTile(
                        label: 'dark_mode',
                        icon: FontAwesomeIcons.solidMoon,
                        child: Center(
                          child: Switch.adaptive(
                              value: AppCubit.get(context).isDark,
                              onChanged: (newValue) {
                                // newValue = AppCubit.get(context).changeThemeModeViaSwitch();
                                Navigator.pop(context);
                              }),
                        ),
                        onPressed: () {},
                      ),
                      YSpace.extreme,
                      _DrawerListTile(
                        label: 'location',
                        icon: Icons.location_on_sharp,
                        onPressed: () {},
                      ),
                      YSpace.extreme,
                      _DrawerListTile(
                        label: 'faq',
                        icon: FontAwesomeIcons.question,
                        // onPressed: ()=>navigateTo(context, FaqScreen()),
                      ),
                      YSpace.extreme,
                      _DrawerListTile(
                        label: 'about',
                        icon: FontAwesomeIcons.lightbulb,
                        onPressed: () {
                          // CustomDialog.showMyAboutDialog(context);
                        },
                      ),
                      YSpace.extreme,
                      _DrawerListTile(
                        label: 'sign_out',
                        icon: FontAwesomeIcons.signOutAlt,
                        onPressed: () {
                          cubit.signOut();
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
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

class _DrawerListTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isBackgroundColor;
  final VoidCallback? onPressed;
  const _DrawerListTile(
      {Key? key,
      this.isBackgroundColor = false,
      this.onPressed,
      required this.label,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: null,
      color: (isBackgroundColor)
          ? (AppCubit.get(context).isDark ? Colors.grey[850] : Colors.grey[100])
          : (null),
      elevation: 0.0,
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(icon),
            ),
            XSpace.extreme,
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionalListTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget? child;
  final VoidCallback? onPressed;

  const _OptionalListTile(
      {Key? key,
      this.child,
      this.onPressed,
      required this.label,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        elevation: 0.0,
        padding: EdgeInsets.all(8.0),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            // expandIcon: IconBroken.Arrow___Down_2,
            // collapseIcon: IconBroken.Arrow___Up_2,
            iconColor: Theme.of(context).primaryColor,
            iconSize: 18,
          ),
          header: Row(
            children: [
              CircleAvatar(
                child: Icon(icon),
              ),
              XSpace.extreme,
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          collapsed: Visibility(
            visible: false,
            child: Text(''),
          ),
          expanded: child ?? Container(),
        ));
  }
}


import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/custom_divider.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/sections_divider.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/components/reusable/tiles/expandable_tile.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_state.dart';
import 'package:e_shop/shared/models/app/countries.dart';
import 'package:e_shop/shared/models/app/languages.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:e_shop/styles/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ChangeAppColorsSuccessState) {
            Utils.showAlertDialog(
                context,
                title:'changed_successfully'.tr(),
              content: 'restart_app'.tr(),
              actionLabelA: 'cancel'.tr(),
              actionLabelB: 'i_understand'.tr(),
              onPressedA: ()=>navigateBack(context),
            );

        }
        if (state is ChangeAppColorsErrorState) {
           Utils.showSnackBar(
             context, 'something_went_wrong'.tr(),
             dialogueStates: DialogueStates.ERROR,);
         }
        if (state is ChangeLanguageErrorState) {
          Utils.showSnackBar(
            context, 'something_went_wrong'.tr(),
            dialogueStates: DialogueStates.ERROR,);
        }
        if (state is ChangeLanguageSuccessState){
          Utils.showSnackBar(
            context, 'restart_app'.tr(),
            dialogueStates: DialogueStates.WARNING,);

        }
      },
      builder: (context, state) {
        var appCubit=AppCubit.get(context);
        var isDark = AppCubit.get(context).isDark;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MediaQuery(
            data: MediaQueryData(
              textScaleFactor: appCubit.fontSizeValue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _LanguagePickerSection(appCubit,),
                  // CustomOutlinedButton.icon(label: Text('Data'),icon: Icons.three_k, onPressed:(){}),
                  //  CustomOutlinedButton(child:  Text('Data'), onPressed: (){}),
                  _CountrySection(appCubit),
                  SectionsDivider(
                    isDark,
                    style: SectionDividerStyle.h4,
                  ),
                  _DarkModeSection(isDark),
                  SectionsDivider(
                    isDark,
                    style: SectionDividerStyle.h4,
                  ),
                  _AppearanceSection(appCubit),
                  _FontSizeSection(appCubit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// first section
class _LanguagePickerSection extends StatelessWidget {
  final AppCubit appCubit;
  const _LanguagePickerSection( this.appCubit,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SettingSection(
          'language'.tr(),
         appCubit.isDark,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<dynamic>(
                icon: const Icon(FontAwesomeIcons.globeAfrica),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                // iconDisabledColor: Colors.grey,
                dropdownColor:
                   appCubit.isDark ? kDarkSecondaryColor : kLightSecondaryColor,
                iconEnabledColor: kSecondaryColor,
                value: appLanguage,
                onChanged: (newValue)=>appCubit.changeLanguage(newValue, context),
                items: LanguagesModel.getLanguages
                    .map((e) => DropdownMenuItem<dynamic>(
                          value: e.value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  e.image,
                                  height: 20,
                                  width: 20,
                                ),
                                XSpace.normal,
                                Text(
                                  e.name,
                                  style: TextStyle(
                                    color:appCubit.isDark
                                        ? Colors.white
                                        : kSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ),
        _Divider(appCubit.isDark),

        // LanguagesModel.getCountries.map((e) => null)
      ],
    );
  }
}

///second section
class _CountrySection extends StatelessWidget {
  final AppCubit appCubit;
  const _CountrySection(this.appCubit, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingSection(
          'country_section'.tr()+'   '+'( ${appCubit.initialValue} )',
          appCubit.isDark,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<dynamic>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:const BorderSide(color: Colors.transparent),
                  ),
                  // label: Text(
                  //   'country'.tr(),
                  //   style: TextStyle(
                  //       color:
                  //       appCubit.isDark ? Colors.white : kSecondaryColor),
                  // ),
                ),
                iconDisabledColor: Colors.grey,
                dropdownColor:
                appCubit.isDark ? kDarkSecondaryColor : kLightSecondaryColor,
                iconEnabledColor: kSecondaryColor,
                value: appCubit.initialValue,
                onChanged: (value) => appCubit.changeCountryValue(value!),
                items: CountriesModel.getCountries
                    .map((e) => DropdownMenuItem<dynamic>(
                  value: e.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Row(
                      children: [
                        Image.asset(
                          e.image,
                          height: 20,
                          width: 20,
                        ),
                        XSpace.normal,
                        Text(
                          e.name,
                          style: TextStyle(
                            color: appCubit.isDark
                                ? Colors.white
                                : kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
                    .toList()),
          ),
        ),
        _Divider(appCubit.isDark),
      ],
    );
  }
}

///third section
class _DarkModeSection extends StatelessWidget {
  final bool isDark;

  const _DarkModeSection(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Column(
          children: [
            _SettingSection(
              'dark_mode'.tr()+'   ' +'${isDark?'on'.tr():'off'.tr()}',
              isDark,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   const  Icon(Icons.light_mode,color: Colors.amber,),
                    Switch.adaptive(
                      activeColor: kSecondaryColor,
                        value: AppCubit.get(context).isDark,
                        onChanged: (newValue) {
                          newValue = AppCubit.get(context).changeAppThemeModeSwitch();
                        }),
                    Icon(Icons.dark_mode,color: isDark?Colors.grey:Colors.black87,),
                  ],
                ),
              ),
            ),
            YSpace.normal,
            _Divider(isDark),
          ],
        );
      },
    );
  }
}

/// 4th Section
class _AppearanceSection extends StatelessWidget {
  final AppCubit appCubit;
  const _AppearanceSection(this.appCubit,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Colors
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          'appearance'.tr(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      Card(
        color: AppCubit.get(context).isDark
            ? kDarkSecondaryColor
            : kLightSecondaryColor,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 12.0,end: 5.0,start: 5.0),
          child: Row(
            children:
            List.generate(ColorPalette.palette.length, (index) {
              return Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    MaterialButton(
                      height: 80,
                      padding:const EdgeInsets.all(5.0),
                      onPressed: ()=>appCubit.changeAppColors(index: index),
                      child: Container(
                        height: 50,
                        color:ColorPalette.palette[index].colors,
                      ),
                    ),
                    if(colorIndex==index)  Icon(
                      Icons.circle,
                      size: 10,
                      color: ColorPalette.palette[index].colors,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      YSpace.normal,
      _Divider(appCubit.isDark),

    ],
    );
  }
}

///5th Section
class _FontSizeSection extends StatelessWidget {
  final AppCubit appCubit;
  const _FontSizeSection(this.appCubit, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// fontSize
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text(
                'font_size'.tr(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Spacer(),
              IconButton(onPressed: ()=>AppCubit.get(context).restoreFontSize(), icon: const Icon(Icons.refresh),tooltip: 'reset'.tr(),),
            ],
          ),
        ),
        Card(
          color: AppCubit.get(context).isDark
              ? kDarkSecondaryColor
              : kLightSecondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider.adaptive(
                  value: AppCubit.get(context).fontSizeValue,
                  min: 0.25,
                  max: 1.5,
                  divisions: 5,
                  label:
                  'x ${AppCubit.get(context).fontSizeValue.toString()}',
                  onChanged: (newValue) => AppCubit.get(context)
                      .changeFontSize(newValue: newValue),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0),
                  child: Text(
                    '• ${'normal_is'.tr()} x1',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class _SettingSection extends StatelessWidget {
  final String label;
  final bool isDark;
  final Widget? child;
  final IconData? prefixIcon;
  const _SettingSection(
    this.label,
    this.isDark, {
    Key? key,
    this.child,
        this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableListTile(
      // onPressed: onPressed,
      primaryColor: isDark ? kLightPrimaryColor : kDarkSecondaryColor,
      prefixIconColor: isDark?  kDarkSecondaryColor:kLightPrimaryColor,
      prefixIcon: prefixIcon,
      fontSize: 14.0,
      iconsSize: 12,
      iconPadding: 0,
      label: label,
      expandIcon: Icons.arrow_forward_ios_rounded,
      collapseIcon: Icons.arrow_back_ios_rounded,
      child: child,
    );
  }
}
class _Divider extends StatelessWidget {
  final bool isDark;

  const _Divider(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDark ? XDivider.faded(height: 0.5) : XDivider.semiFaded(height: 1);
  }
}

// abstract class MyOutlinedButton extends StatelessWidget{
//   final Widget child ;
//   final  VoidCallback? onPressed;
//   const MyOutlinedButton({Key? key,required this.child,required this.onPressed}):super(key: key);
//   // @override
//   // Widget build(BuildContext context) {
//   //   return OutlinedButton(
//   //       onPressed: onPressed,
//   //       child: child,
//   //   ) ;
//   // }
// }
// class CustomOutlinedButton extends MyOutlinedButton {
//   CustomOutlinedButton({
//      Key? key,
//      required Widget child ,
//      required VoidCallback ? onPressed,
// }) : super(child: child,onPressed: onPressed,key: key);
//
//   factory CustomOutlinedButton.icon({
//     Key? key,
//     required VoidCallback ? onPressed,
//     required IconData icon,
//     required Widget label,
//   })=> CustomOutlinedButton(
//       child: _IconLabelButton(icon: icon, label: label),
//       onPressed: onPressed);
//
//   @override
//   Widget build(BuildContext context) {
//      return OutlinedButton(
//          onPressed: onPressed,
//          child: child);
//   }
// }
// class _IconLabelButton extends StatelessWidget {
//   final IconData icon;
//   final Widget label;
//   final VoidCallback ? onPressed;
//   _IconLabelButton({required this.icon,required this.label,this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//      return Row(
//        mainAxisSize: MainAxisSize.min,
//        children: [
//          label,
//          Icon(icon),
//        ],
//      );
//   }
//
//
// }
//

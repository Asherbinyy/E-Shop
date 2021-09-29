import 'package:e_shop/models/app/languages.dart';
import 'package:e_shop/network/local/cache_helper.dart';
import 'package:e_shop/network/local/cached_values.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   bool isDark = AppCubit.get(context).isDark ;
    return Column(
      children: [
        _LanguagePicker(isDark: isDark),
      ],
    );
  }
}

class _LanguagePicker extends StatefulWidget {
  const _LanguagePicker({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  State<_LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<_LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: double.infinity,
            color: kDarkSecondaryColor.withOpacity(0.5),
            padding: EdgeInsets.all(8.0),
            child: const Text('Language')),
        YSpace.normal,
        // LanguagesModel.getCountries.map((e) => null)
        DropdownButtonFormField<dynamic>(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              // label: Text(
              //   'Country',
              //   style: TextStyle(
              //       color:
              //       isDark ? Colors.white : kPrimaryColor),
              // ),
            ),
            // iconDisabledColor: Colors.grey,
            dropdownColor:
            widget.isDark ? kDarkSecondaryColor : kLightSecondaryColor,
            iconEnabledColor: kPrimaryColor,
            value: appLanguage,
            onChanged: (value) {
              setState(() {
                appLanguage = value ;
                CacheHelper.saveData(APP_LANGUAGE, value).then((value){
                  if (value){
                    DefaultDialogue.showSnackBar(
                        context, 'Please , restart your app to make changes take place properly',
                        isDark:  widget.isDark,
                        dialogueStates: DialogueStates.WARNING);
                  }
                });
              });
            },
            items: LanguagesModel.getLanguages
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
                        color: widget.isDark
                            ? Colors.white
                            : kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ))
                .toList()),
      ],
    );
  }
}

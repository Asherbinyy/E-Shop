import 'dart:io';

import 'package:e_shop/services/methods/operating_system_options.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/reusable/text/custom_text.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum DialogueStates {
  SUCCESS,
  WARNING,
  ERROR,
  NONE,
}

/// very short lasts for : 500 millisecond
///short lasts for : 1 sec
/// normal lasts for :  3 sec
/// average lasts for : 5 sec
/// long lasts for :  7 sec
enum SnackBarDuration { veryShort, short, normal, average, long }

class Utils {
  Utils._();

  /// This method changes the dialogue background according to it's state
  static Color _backgroundColor(DialogueStates dialogueStates, bool isDark) {
    Color _color;
    switch (dialogueStates) {
      case DialogueStates.SUCCESS:
        _color = Colors.green;
        break;
      case DialogueStates.WARNING:
        _color = Colors.amber;
        break;
      case DialogueStates.ERROR:
        _color = Colors.red;
        break;
      case DialogueStates.NONE:
        _color = isDark ? kDarkSecondaryColor : kLightSecondaryColor;
        break;
    }
    return _color;
  }

  /// This method gets snackBar duration
  static _getDuration(SnackBarDuration duration) {
    Duration _duration;
    switch (duration) {
      case SnackBarDuration.veryShort:
        _duration = const Duration(milliseconds: 500);
        break;
      case SnackBarDuration.short:
        _duration = const Duration(seconds: 1);
        break;
      case SnackBarDuration.normal:
        _duration = const Duration(seconds: 3);
        break;
      case SnackBarDuration.average:
        _duration = const Duration(seconds: 5);
        break;
      case SnackBarDuration.long:
        _duration = const Duration(seconds: 7);
        break;
    }
    return _duration;
  }

  static Future<bool?> showToast(
    final String label, {
    required final DialogueStates dialogueStates,
    final bool isDark = false,
  }) {
    return Fluttertoast.showToast(
      msg: label,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: _backgroundColor(dialogueStates, isDark),
      textColor:
          dialogueStates == DialogueStates.NONE ? Colors.black87 : Colors.white,
      fontSize: 16.0,
      // webShowClose: true,
    );
  }

  static void showSnackBar(
    final BuildContext context,
    final String label, {
    required final DialogueStates dialogueStates,
    final bool isDark = false,
    final Color labelColor = Colors.white,
    final bool isFloating = true,
    final bool isAction = false,

    /// Duration the snackBar appears on screen
    final SnackBarDuration snackBarDuration = SnackBarDuration.short,

    /// Used in case we want user to interact with snackBar
    final String? actionLabel,
    final Function? onActionTap,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: _getDuration(snackBarDuration),
        content: Text(
          label,
          style: TextStyle(color: labelColor),
        ),
        backgroundColor: _backgroundColor(dialogueStates, isDark),
        behavior:
            isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        action: isAction
            ? SnackBarAction(
                label: actionLabel ?? '',
                onPressed: () {
                  onActionTap!();
                },
                textColor: labelColor,
              )
            : null,
      ),
    );
  }

  static void showMyAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: Image(
        image:
            AssetImage(AppCubit.get(context).isDark ? kLogoDark : kLogoLight),
        height: 50,
        width: 50,
      ),
      applicationLegalese: 'app_legalese'.tr(),
      applicationVersion: '${'version'} : ${'beta version'}',
    );
  }

  static void showAlertDialog(
    BuildContext context, {
    final String title = '',
    final bool isDestructiveAction = false,
    final String content = '',
    final String actionLabelA = 'ok',
    final VoidCallback? onPressedA,
    final VoidCallback? onPressedB,
    final String actionLabelB = 'cancel',
  }) {
    if (OperatingSystemOptions.getOs() == 'ios')
      showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                title,
                // style: Theme.of(context).textTheme.headline6,
              ),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: onPressedA,
                  child: Text(
                    isDestructiveAction
                        ? 'Delete'.toUpperCase()
                        : actionLabelA.toUpperCase(),
                    style: TextStyle(
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => onPressedB ?? navigateBack(context),
                  child: Text(actionLabelB.toUpperCase()),
                ),
              ],
            );
          });
    else
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                title,
                // style: Theme.of(context).textTheme.headline6,
              ),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: onPressedA,
                  child: Text(
                    isDestructiveAction
                        ? 'Delete'.toUpperCase()
                        : actionLabelA.toUpperCase(),
                  ),
                ),
                TextButton(
                  onPressed: () => onPressedB ?? Navigator.pop(context),
                  child: Text(actionLabelB.toUpperCase()),
                ),
              ],
            );
          });
  }

  static void showIOSModalSheet(
    BuildContext context, {
    Key? key,
    String? title,
    String? message,
    String? mainButtonLabel,
    VoidCallback? onMainPressed,
    List<Widget>? actions,
  }) {

      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              cancelButton: CupertinoButton(
                pressedOpacity: 0.5,
                child: CustomText(
                  mainButtonLabel ?? "cancel",
                  isUpperCase: true,
                ),
                onPressed: () => onMainPressed ?? navigateBack(context),
              ),
              title: title != null ? CustomText(title) : null,
              key: key,
              actions: actions,
              message: CustomText(message ?? "..",textAlign: TextAlign.left,textHeight: 1.2,),
            );
          });

  }

  static void showAndroidBottomSheet(
    BuildContext context, {
    required Widget child,
        ShapeBorder ? shape,
        Color ? backgroundColor,
        bool ? enableDrag,
        bool ? isScrollControlled,
        bool ? isDismissible,
  }) {
    showModalBottomSheet(
        context: context,
        shape: shape ,
        backgroundColor: backgroundColor,
        enableDrag: enableDrag??true,
        isScrollControlled:isScrollControlled??false ,
        isDismissible: isDismissible ?? true,
        builder: (context) {
          return child;
        });
  }


  static void showBasicDialog (BuildContext context, {required Widget child}){
    showDialog(context: context, builder: (context){
      return child;
    });
  }
}

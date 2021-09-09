import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum DialogueStates {
  SUCCESS,
  WARNING,
  ERROR,
  NONE,
}

class DefaultDialogue {
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

  static Future<bool?> showToast(
    final String label, {
    required final DialogueStates dialogueStates,
    required final bool isDark,
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
    required final bool isDark,
    final Color labelColor = Colors.white,
    final bool isFloating = true,
    final bool isAction = false,

    /// Used in case we want user to interact with snackBar
    final String? actionLabel,
    final VoidCallback? onActionTap,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
                onPressed: () => onActionTap,
                textColor: labelColor,
              )
            : null,
      ),
    );
  }
}

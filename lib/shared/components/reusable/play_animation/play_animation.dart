import '/../shared/components/reusable/spaces/spaces.dart';
import '/../styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

enum PlayedAnimationStyle {WELL_DONE}

class PlayAnimation {
  static void animationDialog(
      BuildContext context,
      PlayedAnimationStyle style,
      {
        bool isDismissible = true,
        bool isDark = true,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        Widget _widget ;
        switch (style){
          case PlayedAnimationStyle.WELL_DONE:
          _widget = _WellDone();
            break;
        }
        return _widget;
        },
      barrierDismissible: isDismissible,
    );
  }
}

class _WellDone extends StatelessWidget {
  const _WellDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text('well_done'.tr(),style: TextStyle(fontSize: 20),),
          ),
          YSpace.normal,
          Text('lets_set_up_account'.tr(),style: TextStyle(fontSize: 14,color: Colors.grey[400])),
          LottieBuilder.asset (kCongratulationLottie,repeat: false,height: 200,width: 200,),
        ],
      ),
    );
  }
}

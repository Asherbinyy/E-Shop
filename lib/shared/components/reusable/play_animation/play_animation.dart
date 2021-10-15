import '/shared/cubit/app_cubit.dart';
import '/../shared/components/reusable/spaces/spaces.dart';
import '/../styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

/// REVIEWED
/// TO DO : USE OOP TO OPTIMIZE CODE
enum PlayedAnimationStyle {WELL_DONE,SUCCESS,FAILED}

class PlayAnimation {
  static void animationDialog(
      BuildContext context,
      PlayedAnimationStyle style,
      {
        bool isDismissible = true,
        bool isDark = true,
         String ? msg ,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        Widget _widget ;
        switch (style){
          case PlayedAnimationStyle.WELL_DONE:
          _widget = _WellDone();
            break;
          case PlayedAnimationStyle.SUCCESS:
            _widget =_Success(msg: msg);
            break;
          case PlayedAnimationStyle.FAILED:
            _widget=_Failed(msg: msg,);
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
class _Success extends StatelessWidget {
  final String ? msg ;
  const _Success({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppCubit.get(context).isDark
          ? kDarkSecondaryColor
          : kLightSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(kSuccessLottie, repeat: false, height: 300, width: 300),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '$msg??''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:  (AppCubit.get(context).isDark ? Colors.white : Colors.black87 )
                         ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
class _Failed extends StatelessWidget {
  final String ? msg ;
  const _Failed({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppCubit.get(context).isDark
          ? kDarkSecondaryColor
          : kLightSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(kFailedLottie, repeat: false, height: 300, width: 300),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '$msg??''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:  (AppCubit.get(context).isDark ? Colors.white : Colors.black87 )
                         ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

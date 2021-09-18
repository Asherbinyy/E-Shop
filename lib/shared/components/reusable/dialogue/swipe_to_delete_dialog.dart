import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SwipeToDeleteDialog extends StatelessWidget {
  const SwipeToDeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightThirdColor,
      child:  SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(kSwipeLeftLottie,reverse: true,fit: BoxFit.fitWidth,width: 150,),
            Text('swipe to delete Items',style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

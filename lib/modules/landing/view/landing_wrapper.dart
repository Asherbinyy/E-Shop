part of 'landing_imports.dart';

class LandingWrapper extends StatelessWidget {
  final Widget screen;

  const LandingWrapper({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // used to hide status bar
        OperatingSystemOptions.hideStatusBar();
        return BlocProvider(
          create: (context) => LandingCubit(),
          child: BlocListener<LandingCubit, LandingStates>(
            listener: (context, state) {
              if (state is SwitchToPreviewerSuccessState)
                LandingCubit.get(context).hideBrandIcon();

              if (state is SwitchToPreviewerErrorState)
                Utils.showSnackBar(
                  context,
                  'choose_one_lang'.tr(),
                  dialogueStates: DialogueStates.NONE,
                  isDark: true,
                );
              if (state is PlayFinishedAnimationState) {
                PlayAnimation.animationDialog(context, PlayedAnimationStyle.WELL_DONE);
                Future.delayed(Duration(seconds: 2)).then((value) {
                  CacheHelper.saveData(LANDING, true).then((value) {
                    if (value) navigateToAndFinish(context, const RegisterScreen());
                  });
                });
              }
            },
            child: screen,
          ),
        );
      }
    );
  }
}

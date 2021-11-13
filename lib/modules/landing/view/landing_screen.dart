part of 'landing_imports.dart';
/// reviewed
void landingScreenListener(BuildContext context, LandingStates state) {
  if (state is SwitchToPreviewerSuccessState)
    LandingCubit.get(context).hideBrandIcon();

  if (state is SwitchToPreviewerErrorState)
    DefaultDialogue.showSnackBar(
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
}

class LandingScreen extends StatelessWidget {
  static String id = 'LandingScreen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        // used to hide status bar
        OperatingSystemOptions.hideStatusBar();
        return BlocProvider(
          create: (context) => LandingCubit(),
          child: BlocConsumer<LandingCubit, LandingStates>(
            listener: (context, state) => landingScreenListener(context, state),
            builder: (context, state) {
              LandingCubit cubit = LandingCubit.get(context);
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: SecondaryAppBar(
                  actions: cubit.isLangChoosed
                      ? [SkipButton(_theme.textTheme, cubit)]
                      : null,
                ),
                body: Container(
                  width: double.infinity,
                  decoration: LandingDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MyConditionalBuilder(
                      condition: cubit.isWelcomeDone,
                      onBuild: BuildPreviewer(cubit, _theme),
                      onError: BuildWelcome(cubit, _theme),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}



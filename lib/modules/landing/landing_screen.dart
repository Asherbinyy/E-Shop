import '../../shared/components/reusable/play_animation/play_animation.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '../../shared/components/methods/navigation.dart';
import '../../shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../modules/register/register_screen.dart';
import '../../network/local/cached_values.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '/models/app/landing.dart';
import '/network/local/cache_helper.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'cubit/landing_cubit.dart';
import 'cubit/landing_states.dart';
/// reviewed
void landingScreenListener (BuildContext context,LandingStates state){
  if (state is SwitchToPreviewerSuccessState) LandingCubit.get(context).hideBrandIcon();

  if (state is SwitchToPreviewerErrorState)
    DefaultDialogue.showSnackBar(
      context, 'choose_one_lang'.tr(),
      dialogueStates: DialogueStates.NONE,
      isDark: true,
    );
  if (state is PlayFinishedAnimationState)  {
    PlayAnimation.animationDialog(context, PlayedAnimationStyle.WELL_DONE);
    Future.delayed(Duration(seconds: 2)).then((value) {
      CacheHelper.saveData(LANDING, true).then((value) {
        if (value) navigateToAndFinish(context, RegisterScreen());
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
        var _theme = Theme.of(context);
        // used to hide status bar
        hideStatusBar();
        return BlocProvider(
            create: (context) => LandingCubit(),
            child: BlocConsumer<LandingCubit, LandingStates>(
              listener: (context, state) => landingScreenListener(context, state),
              builder: (context, state) {
                LandingCubit cubit = LandingCubit.get(context);
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      actions: cubit.isLangChoosed
                          ? [
                            _skipButton(context, _theme.textTheme,cubit)
                            ]
                          : null),
                  body: Container(
                    width: double.infinity,
                    decoration:landingDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MyConditionalBuilder(
                          condition: cubit.isWelcomeDone,
                          builder: _Previewer(cubit, _theme),
                          feedback: _Welcome(cubit, _theme),
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
  Widget _skipButton (BuildContext context,TextTheme textTheme,LandingCubit cubit)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      child: Text(
        'Skip'.tr().toUpperCase(),
        style: textTheme
            .subtitle2!
            .copyWith(color: kLightSecondaryColor),
      ),
      onPressed: () =>cubit.onSkipChanged(),
    ),
  );
}

class _Welcome extends StatelessWidget {
  final ThemeData theme;
  final LandingCubit cubit;
  const _Welcome(this.cubit, this.theme, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Center(
                child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
                child: Text(
              'welcome_to_app_name'.tr(),
              style: theme
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            )),
            FittedBox(
              child: Image.asset(
                kHiImage,
                height: height * 0.05,
                width: width * 0.15,
              ),
            ),
          ],
        ))),
        Expanded(
          child: Hero(
            tag: 'icon',
            child: Center(
              child: SizedBox(
                height: height * 0.25,
                width: width * 0.6,
                child: Image.asset(kLogoDark),
              ),
            ),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'quick_tour'.tr(),
              style: theme.textTheme.headline5?.copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'choose_language_to_continue'.tr(),
              style:
                  theme.textTheme.bodyText1!.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.left,
            ),
          ],
        )),
        Expanded(
            child: Theme(
              data:ThemeData(
                  unselectedWidgetColor: Colors.white30,
                  primarySwatch: Colors.amber,
              ),
              child: Column(
          children: [
              CheckboxListTile(
                value: cubit.isArabic,
                onChanged: (_) => cubit.chooseLanguage( 'ar'),
                secondary: Image.asset(
                  kArabicFlag,
                  height: height * 0.04,
                  width: width * 0.1,
                ),
                title: Text(
                  'arabic'.tr(),
                  style: theme
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kLightSecondaryColor, fontSize: 17),
                ),
              ),
              CheckboxListTile(
                value: cubit.isEnglish,
                onChanged: (_) => cubit.chooseLanguage('en'),
                secondary: Image.asset(
                  kEnglishFlag,
                  height: height * 0.04,
                  width: width * 0.1,
                ),
                title: Text(
                  'english'.tr(),
                  style: theme
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kLightSecondaryColor, fontSize: 17),
                ),
              ),
          ],
        ),
            ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: ElevatedButton(
            onPressed: () => cubit.switchToPreviewer(),
            child: FittedBox(child: Text('start_tour'.tr().toUpperCase())),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              minimumSize: Size(width * 0.3, height * 0.06),
            ),
          ),
        ),
      ],
    );
  }
}

class _Previewer extends StatelessWidget {
  final LandingCubit cubit;
  final ThemeData theme;
  const _Previewer(
    this.cubit,
    this.theme,
     {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    PageController pageController = PageController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (cubit.showBrandIcon) Hero(
              tag: 'icon',
              child: Center(
                  child: SizedBox(
                height: _height * 0.3,
                width: _width * 0.8,
                child: Image.asset(kLogoDark),
              ),),
          ),
        SizedBox(
          height: _height * 0.05,
        ),
        if (cubit.isGetStartedTitleShown) _getStartedTitle(_height),
        SizedBox(
          height: _height * 0.01,
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) =>cubit.onPageChanged(index),
            itemCount: LandingModel.getLandingList.length,
            itemBuilder: (context, index) {
              var item = LandingModel.getLandingList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Image.asset(item.imageUrl!)),
                  Text(
                    item.title!,
                    style: theme.textTheme.headline5?.copyWith(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                   YSpace.extreme,
                  Text(item.body!,
                      style: theme
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[400])),
                  YSpace.extreme,
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: _height * 0.01,
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: SmoothPageIndicator(
            controller: pageController,
            count: LandingModel.getLandingList.length,
            effect: SwapEffect(
              dotWidth: _width * 0.08,
              dotHeight: _height * 0.01,
              dotColor: kDarkThirdColor,
              activeDotColor: kPrimaryColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: ()=>cubit.onNextChanged(pageController),
          child: cubit.isLastScreen
              ? Text('begin'.tr().toUpperCase())
              : Text('continue'.tr().toUpperCase()),
          style: OutlinedButton.styleFrom(
            backgroundColor: cubit.isLastScreen
                ? kSecondaryColor
                : kPrimaryColor,
            minimumSize: Size(_width * 0.3, _height * 0.06),
          ),
        ),
      ],
    );
  }

  Widget _getStartedTitle(double _height) =>Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: _height * 0.0008,
                color: kLightSecondaryColor,
              ),
            )),
            Expanded(
              child: Text(
                'get_started'.tr(),
                style:const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: _height * 0.0008,
                color: kLightSecondaryColor,
              ),
            )),
          ],
        );

}


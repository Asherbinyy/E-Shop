import 'package:e_shop/modules/register/register_screen.dart';
import 'package:e_shop/network/local/cached_values.dart';
import 'package:e_shop/shared/components/methods/methods.dart';

import '/models/app/landing_model.dart';
import '/network/local/cache_helper.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit/landing_cubit.dart';
import 'cubit/landing_states.dart';

class LandingScreen extends StatelessWidget {
  static String id = 'LandingScreen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController = PageController();

    // used to hide status bar

    return Builder(
      builder: (context) {
        hideStatusBar();
        return BlocProvider(
            create: (context) => LandingCubit(),
            child: BlocConsumer<LandingCubit, LandingStates>(
              listener: (context, state) {
                if (state is ChangeGetStartedErrorState)
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please choose one language '),
                    behavior: SnackBarBehavior.floating,
                  ));
                if (state is ChangeGetStartedSuccessState)
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    LandingCubit.get(context).hideBrandIcon();
                  });
              },
              builder: (context, state) {
                LandingCubit cubit = LandingCubit.get(context);
                return Scaffold(
                  key: _scaffoldKey,
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      actions: cubit.isLangChoosed
                          ? [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  child: Text(
                                    'Skip'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: kLightSecondaryColor),
                                  ),
                                  onPressed: () async {
                                    showStatusBar();
                                    await CacheHelper.saveData(LANDING, true)
                                        .then((value) {
                                      if (value) {
                                        Navigator.pushNamed(context, RegisterScreen.id);
                                      }
                                    });
                                  },
                                ),
                              )
                            ]
                          : null),
                  body: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColorDarker,

                          /// primary Color but Darker
                          kDarkSecondaryColor,
                        ],
                        stops: [0.1, 1],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MyConditionalBuilder(
                          condition: cubit.isFirstDone,
                          builder: _Previewer(cubit, _theme, _pageController),
                          feedback: _Welcome(cubit, _theme)),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
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
              'Welcome To E-Shop',
              style: Theme.of(context)
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
              'Let\'s have a quick tour ',
              style: theme.textTheme.headline5?.copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'but First choose your mother language in order to continue ',
              style:
                  theme.textTheme.bodyText1!.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.left,
            ),
          ],
        )),
        Expanded(
            child: Column(
          children: [
            CheckboxListTile(
              value: cubit.isArabic,
              onChanged: (newValue) => cubit.chooseLanguage(newValue, 'ar'),
              secondary: Image.asset(
                kArabicFlag,
                height: height * 0.04,
                width: width * 0.1,
              ),
              title: Text(
                'العربية',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: kLightSecondaryColor, fontSize: 17),
              ),
            ),
            CheckboxListTile(
              value: cubit.isEnglish,
              onChanged: (newValue) => cubit.chooseLanguage(newValue, 'en'),
              secondary: Image.asset(
                kEnglishFlag,
                height: height * 0.04,
                width: width * 0.1,
              ),
              title: Text(
                'English',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: kLightSecondaryColor, fontSize: 17),
              ),
            ),
          ],
        )),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: ElevatedButton(
            onPressed: () => cubit.changeGetStarted(),
            child: FittedBox(child: Text('start tour ! '.toUpperCase())),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColorDarker,
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
  final PageController pageController;
  const _Previewer(
    this.cubit,
    this.theme,
    this.pageController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (cubit.showBrandIcon)
          Hero(
              tag: 'icon',
              child: Center(
                  child: SizedBox(
                height: _height * 0.3,
                width: _width * 0.8,
                child: Image.asset(kLogoDark),
              ))),
        SizedBox(
          height: _height * 0.05,
        ),
        if (cubit.isGetStartedTitleShown)
          Row(
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
                  'Get Started ',
                  style: theme.textTheme.bodyText1,
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
          ),
        SizedBox(
          height: _height * 0.01,
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              cubit.hideGetStartedTitle('shown');
              if (index == LandingModel.getLandingList.length - 1) {
                cubit.changeLastScreen('last');
              } else {
                if (index == 1)
                  cubit.hideGetStartedTitle('hidden');
                else
                  cubit.hideGetStartedTitle('shown');
                cubit.changeLastScreen('notLast');
              }
            },
            itemCount: LandingModel.getLandingList.length,
            itemBuilder: (context, index) {
              var item = LandingModel.getLandingList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Image.asset(item.imageUrl!)),
                  Text(
                    item.title!,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(item.body!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey[400])),
                  SizedBox(
                    height: 20,
                  )
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
              activeDotColor: kPrimaryColorDarker,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: cubit.isLastScreen
              ? Text('Begin ! '.toUpperCase())
              : Text('Continue'.toUpperCase()),
          style: OutlinedButton.styleFrom(
            backgroundColor: cubit.isLastScreen
                ? kSecondaryColorDarker
                : kPrimaryColorDarker,
            minimumSize: Size(_width * 0.3, _height * 0.06),
          ),
        ),
      ],
    );
  }
}

class MyConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget builder;
  final Widget? feedback;

  const MyConditionalBuilder(
      {Key? key, required this.condition, required this.builder, this.feedback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetIs;
    if (feedback == null) {
      if (condition == true) {
        widgetIs = builder;
      }
    } else {
      if (condition == true) {
        widgetIs = builder;
      } else {
        widgetIs = feedback;
      }
    }
    return widgetIs;
  }
}

part of 'widgets_landing_imports.dart';

class LandingBuildWelcome extends StatelessWidget {
  const LandingBuildWelcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final theme = Theme.of(context);
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
                  child: CustomText('welcome_to_app_name'.tr(),
                      color: Colors.white)),
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
              CustomText(
                'quick_tour'.tr(),
                textAlign: TextAlign.left,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                'choose_language_to_continue'.tr(),
                textAlign: TextAlign.left,
                color: Colors.grey[400],
              ),
            ],
          )),
          Expanded(
            child: Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.white30,
                primarySwatch: Colors.amber,
              ),
              child: BlocBuilder<LandingCubit, LandingStates>(
                builder: (context, state) {
                  final cubit = LandingCubit.get(context);
                  return Column(
                    children: [
                      CheckboxListTile(
                        value: cubit.isArabic,
                        onChanged: (_) => cubit.chooseLanguage('ar'),
                        secondary: Image.asset(
                          kArabicFlag,
                          height: height * 0.04,
                          width: width * 0.1,
                        ),
                        title: CustomText(
                          'arabic'.tr(),
                          color: kLightSecondaryColor,
                          fontSize: 17,
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
                        title: CustomText(
                          'english'.tr(),
                          color: kLightSecondaryColor,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          BlocBuilder<LandingCubit, LandingStates>(
            builder: (context, state) {
              final cubit = LandingCubit.get(context);
              return Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: ElevatedButton(
                  onPressed: () => cubit.switchToPreviewer(context),
                  child: FittedBox(
                      child: CustomText(
                    'start_tour'.tr(),
                    isUpperCase: true,
                  )),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    minimumSize: Size(width * 0.3, height * 0.06),
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}

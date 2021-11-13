part of 'widgets_landing_imports.dart';
class BuildWelcome extends StatelessWidget {
  final ThemeData theme;
  final LandingCubit cubit;
  const BuildWelcome(this.cubit, this.theme, {Key? key}) : super(key: key);
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
                          style: theme.textTheme.headline5!.copyWith(color: Colors.white),
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
            data: ThemeData(
              unselectedWidgetColor: Colors.white30,
              primarySwatch: Colors.amber,
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  value: cubit.isArabic,
                  onChanged: (_) => cubit.chooseLanguage('ar'),
                  secondary: Image.asset(
                    kArabicFlag,
                    height: height * 0.04,
                    width: width * 0.1,
                  ),
                  title: Text(
                    'arabic'.tr(),
                    style: theme.textTheme.subtitle1!
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
                    style: theme.textTheme.subtitle1!
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
            onPressed: () => cubit.switchToPreviewer(context),
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

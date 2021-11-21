part of 'widgets_landing_imports.dart';

class LandingSkipButton extends StatelessWidget {
  const LandingSkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingStates>(
      key: key,
      builder: (context, state) {
        final cubit = LandingCubit.get(context);
        return MyConditionalBuilder(
            condition: cubit.isLangChoosed,
            onBuild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: CustomText(
                  'skip'.tr(),
                  isUpperCase: true,
                  color: kLightSecondaryColor,
                ),
                onPressed: () => cubit.onSkipChanged(),
              ),
            ),
              onError:const SizedBox() ,
        );
      },
    );
  }
}

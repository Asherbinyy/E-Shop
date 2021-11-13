part of 'widgets_landing_imports.dart';

class SkipButton extends StatelessWidget {
  final TextTheme textTheme;
  final LandingCubit cubit;
  const SkipButton(this.textTheme, this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        child: Text(
          'skip'.tr().toUpperCase(),
          style: textTheme.subtitle2!.copyWith(color: kLightSecondaryColor),
        ),
        onPressed: () => cubit.onSkipChanged(),
      ),
    );
  }
}

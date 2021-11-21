part of 'widgets_landing_imports.dart';

class LandingBuilder extends StatelessWidget {
  const LandingBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingStates>(
      builder: (context, state) {
        final cubit = LandingCubit.get(context);
        return Container(
          width: double.infinity,
          decoration: LandingDecoration(),
          child: MainPadding(
            child: MyConditionalBuilder(
              condition: cubit.isWelcomeDone,
              onBuild: const LandingBuildPreviewer(),
              onError: const LandingBuildWelcome(),
            ),
          ),
        );
      },
    );
  }
}

part of 'landing_imports.dart';

class LandingScreen extends StatelessWidget {
  static String id = 'LandingScreen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LandingWrapper(
        screen:  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SecondaryAppBar(
        actions: [LandingSkipButton()],
      ),
      body: LandingBuilder(),
    ));
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        // used to hide status bar
        OperatingSystemOptions.hideStatusBar();
        return BlocProvider(
          create: (context) => LandingCubit(),
          child: BlocConsumer<LandingCubit, LandingStates>(
            listener: (context, state) {

            },
            builder: (context, state) {

            ;
            },
          ),
        );
      },
    );
  }
}



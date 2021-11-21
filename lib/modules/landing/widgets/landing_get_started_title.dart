part of 'widgets_landing_imports.dart';

class LandingGetStartedTitle extends StatelessWidget {
  const LandingGetStartedTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return  Row(
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
            style: const TextStyle(color: Colors.white),
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
          ),
        ),
      ],
    );
  }
}

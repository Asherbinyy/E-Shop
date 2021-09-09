import '/layout/cubit/home_cubit.dart';
import '/models/api/profile.dart';
import '/models/app/welcome_message.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
// Used in homeScreen ()
class WelcomeMessageBuilder extends StatefulWidget {
  const WelcomeMessageBuilder({
    Key? key,
    required this.cubit,
    required this.profile,
    required this.isDark,
  }) : super(key: key);

  final HomeCubit cubit;
  final bool isDark;
  final ProfileModel? profile;

  @override
  _WelcomeMessageBuilderState createState() => _WelcomeMessageBuilderState();
}
class _WelcomeMessageBuilderState extends State<WelcomeMessageBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation? _animation;
  Duration _duration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    WelcomeMessageModel _welcomeMessage = WelcomeMessageModel.getWelcomeMessage(
        '${widget.profile?.data?.name?.toUpperCase() ?? ' ' }');
    return Visibility(
      visible: widget.cubit.isWelcomeMessageVisible &&
          _welcomeMessage.backgroundImage != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: InkWell(
          onTap: () => widget.cubit.hideWelcomeMessage(),
          child: AnimatedContainer(
            duration: _duration,
            height: _animation?.value * (height * 0.1) ?? 100,
            width: double.infinity,
            decoration: welcomeCardDecoration(
              AppCubit.get(context).isDark,
              _welcomeMessage.backgroundImage??kNoImageFound,
              glowColor: _welcomeMessage.cardShadow??kDarkPrimaryColor.withOpacity(0.5),
            ),
            child: Center(
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text('${_welcomeMessage.message}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    FittedBox(
                      child: Text('${_welcomeMessage.subMessage}',
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
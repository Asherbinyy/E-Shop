import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/modules/home/all/all_screen.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/bottom_nav_bar/BottomNavItem.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/layout/cubit/home_cubit.dart';
import '../../models/api/user/profile.dart';
import '/models/app/welcome_message.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
// Used in LayoutScreen ()
class WelcomeMessageScreen extends StatefulWidget {
  const WelcomeMessageScreen({
    Key? key,
  }) : super(key: key);


  @override
  _WelcomeMessageScreenState createState() => _WelcomeMessageScreenState();
}
class _WelcomeMessageScreenState extends State<WelcomeMessageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation? _animation;
  Animation? _colorAnimation;
  Duration _duration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);


    _controller.forward();
    _controller.addListener(() {
      setState(() {
        if(_animation!.isCompleted){
          // _controller.reverse();
          Future.delayed(Duration(seconds: 2)).then((value) {
            HomeCubit.get(context).hideWelcomeMessage();
            navigateToAndFinish(context, LayoutScreen());
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Builder(
       builder: (context){
         double height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        bool isDark=  AppCubit.get(context).isDark;
        HomeCubit cubit = HomeCubit.get(context);
        ProfileData ? profile = cubit.profileModel?.data;
        WelcomeMessageModel _welcomeMessage = WelcomeMessageModel.getWelcomeMessage(
            '${profile?.name?.toUpperCase() ?? ' ' }');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          ),
          extendBodyBehindAppBar: true,
          body:  Center(
            child: Visibility(
              visible: cubit.isWelcomeMessageVisible &&
                  _welcomeMessage.backgroundImage != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: InkWell(
                  // onTap: () => navigateTo(context, LayoutScreen()),
                  child: AnimatedContainer(
                    duration: _duration,
                    height: _animation?.value * (height) ?? 100,
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
            ),
          ),
        );
      },
    );
  });
  }
}

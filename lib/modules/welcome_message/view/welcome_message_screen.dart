part of 'import_welcome_messages.dart';
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
  Duration _duration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);
    _controller.forward();
    _controller.addListener(() {
      setState(() {
        if(_animation!.isCompleted){
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
         final height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        final cubit = HomeCubit.get(context);
        final profile = cubit.profileModel?.data;
        final _welcomeMessage = WelcomeMessagesProvider.messageData(
            '${profile?.name?.toUpperCase() ?? ' ' }');
        return Scaffold(
          appBar:SecondaryAppBar(systemOverlayStyle:const SystemUiOverlayStyle(statusBarColor: Colors.transparent) ,),
          extendBodyBehindAppBar: true,
          body:  Center(
            child: Visibility(
              visible: cubit.isWelcomeMessageVisible && _welcomeMessage.backgroundImage != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                child: InkWell(
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
                                  style:const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                            FittedBox(
                              child: Text('${_welcomeMessage.subMessage}',
                                  style:const TextStyle(color: Colors.white70)),
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


part of 'widgets_landing_imports.dart';



class BuildPreviewer extends StatelessWidget {
  final LandingCubit cubit;
  final ThemeData theme;
  const BuildPreviewer(
      this.cubit,
      this.theme, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    PageController pageController = PageController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (cubit.showBrandIcon)
          Hero(
            tag: 'icon',
            child: Center(
              child: SizedBox(
                height: _height * 0.3,
                width: _width * 0.8,
                child: Image.asset(kLogoDark),
              ),
            ),
          ),
        SizedBox(
          height: _height * 0.05,
        ),
        if (cubit.isGetStartedTitleShown) _getStartedTitle(_height),
        SizedBox(
          height: _height * 0.01,
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            physics:const BouncingScrollPhysics(),
            onPageChanged: (index) => cubit.onPageChanged(index),
            itemCount: LandingData.getLandingList.length,
            itemBuilder: (context, index) {
              var item = LandingData.getLandingList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Image.asset(item.imageUrl!)),
                  Text(
                    item.title!,
                    style: theme.textTheme.headline5
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  YSpace.extreme,
                  Text(item.body!,
                      style: theme.textTheme.bodyText1!
                          .copyWith(color: Colors.grey[400])),
                  YSpace.extreme,
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: _height * 0.01,
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: SmoothPageIndicator(
            controller: pageController,
            count: LandingData.getLandingList.length,
            effect: SwapEffect(
              dotWidth: _width * 0.08,
              dotHeight: _height * 0.01,
              dotColor: kDarkThirdColor,
              activeDotColor: kPrimaryColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => cubit.onNextChanged(pageController),
          child: cubit.isLastScreen
              ? Text('begin'.tr().toUpperCase())
              : Text('continue'.tr().toUpperCase()),
          style: OutlinedButton.styleFrom(
            backgroundColor:
            cubit.isLastScreen ? kSecondaryColor : kPrimaryColor,
            minimumSize: Size(_width * 0.3, _height * 0.06),
          ),
        ),
      ],
    );
  }

  Widget _getStartedTitle(double _height) => Row(
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

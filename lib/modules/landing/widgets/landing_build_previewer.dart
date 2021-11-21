part of 'widgets_landing_imports.dart';

class LandingBuildPreviewer extends StatelessWidget {
  const LandingBuildPreviewer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

      return BlocBuilder<LandingCubit, LandingStates>(
        builder: (context, state) {
          final _height = MediaQuery.of(context).size.height;
          final _width = MediaQuery.of(context).size.width;
          final pageController = PageController();
          final cubit = LandingCubit.get(context);
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
              if (cubit.isGetStartedTitleShown) const LandingGetStartedTitle(),
              SizedBox(
                height: _height * 0.01,
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) => cubit.onPageChanged(index),
                  itemCount: LandingData.getLandingList.length,
                  itemBuilder: (context, index) {
                    var item = LandingData.getLandingList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Image.asset(item.imageUrl!)),
                        CustomText(
                          item.title??"",
                          textAlign: TextAlign.left,
                          color: Colors.white,
                        ),
                        YSpace.extreme,
                        CustomText(
                            item.body??"",
                    color: Colors.grey[400]
                           ),
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
                    ? CustomText('begin'.tr(),isUpperCase: true)
                    : CustomText('continue'.tr(),isUpperCase: true),
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      cubit.isLastScreen ? kSecondaryColor : kPrimaryColor,
                  minimumSize: Size(_width * 0.3, _height * 0.06),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

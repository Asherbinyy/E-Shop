import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/models/app/popup_model.dart';
import 'package:e_shop/modules/offer_details/offer_details_screen.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/popup_menu_button/custom_popup_button.dart';
import '/layout/cubit/home_cubit.dart';
import '/models/api/banners.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Used in homeScreen ()
class BannerBuilder extends StatelessWidget {
  final CarouselController carouselController;
  final HomeCubit cubit;
  final List<BannerData> banners;

  const BannerBuilder(this.cubit, this.carouselController,
      {Key? key, required this.banners})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Column(
            children: [
              CarouselSlider(
                items: banners.map((e) {
                  return Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10.0),
                        ),
                        child: Image.network('${e.image}', fit: BoxFit.cover),
                      ),
                      InkWell(
                        onTap: () {
                          if (e.image != null)
                            navigateTo(context, OfferDetailsScreen(e.image));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black45,
                            ),
                            child: Text(
                              'See Offer Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: height * 0.15,
                  autoPlay: true,
                  reverse: false,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.easeInOutCubic,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) =>
                      cubit.changeBannerSlide(index),
                ),
              ),
              SizedBox(height: height * 0.02),
              AnimatedSmoothIndicator(
                effect: SwapEffect(
                  dotHeight: height * 0.004,
                  dotWidth: width * 0.04,
                  activeDotColor: kPrimaryColorDarker,
                ),
                activeIndex: cubit.bannerSlideIndex,
                count: banners.length,
              ),
              SizedBox(height: height * 0.01),
            ],
          ),
          CustomPopUpButton(
            popUps: PopUpModel.bannerOptions,
            icon: Icons.more_vert,
            onSelected:(_)=> cubit.hideBanners(),
          ),
        ],
      );
    });
  }
}

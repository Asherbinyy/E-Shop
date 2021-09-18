import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/models/app/popup.dart';
import '/modules/offer_details/offer_details_screen.dart';
import '/shared/components/builders/product_card.dart';
import '/shared/components/builders/product_header_builder.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/components/reusable/popup_menu_button/custom_popup_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../models/api/home/home.dart';
import '/shared/cubit/app_cubit.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/modules/landing/landing_screen.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangeFavouritesSuccessState) {
          if (state.changeFavouritesModel?.status == true)
            DefaultDialogue.showSnackBar(
                context, '${state.changeFavouritesModel?.message}',
                labelColor:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
                dialogueStates: DialogueStates.NONE,
                isDark: AppCubit.get(context).isDark);
          else
            DefaultDialogue.showSnackBar(
              context,
              '${state.changeFavouritesModel?.message}',
              dialogueStates: DialogueStates.ERROR,
            );
        }
        if (state is ChangeCartSuccessState) {
          if (state.changeCartModel?.status == true)
            DefaultDialogue.showSnackBar(
                context, '${state.changeCartModel?.message}',
                labelColor:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
                dialogueStates: DialogueStates.NONE,
                isDark: AppCubit.get(context).isDark);
          else
            DefaultDialogue.showSnackBar(
              context,
              '${state.changeCartModel?.message}',
              dialogueStates: DialogueStates.ERROR,
            );
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        // List<HomeProducts>? products = HomeCubit.get(context).homeModel?.data?.products;
        List<HomeProducts>? products = cubit.defaultHomeProduct;

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Slider
                if (cubit.banners.isNotEmpty && cubit.isBannerShown)
                  _BannerBuilder(cubit),
                // popular Products
                MyConditionalBuilder(
                  condition: cubit.homeModel?.data != null && cubit.defaultHomeProduct !=null,
                  builder: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductHeaderWidget(title: 'Popular Products'),
                      state is !GetHomeDataLoadingState ? _ProductBuilder(cubit,products,isGrid: cubit.isGrid):kLoadingWanderingCubes,
                      ],
                    ),
                  ),
                  feedback: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: kLoadingFadingCircle),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductBuilder extends StatelessWidget {
  final HomeCubit cubit;
  final List<HomeProducts>? products;
  final bool isGrid ;
  const _ProductBuilder(this.cubit,this.products,{Key? key,required this.isGrid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MyConditionalBuilder(
      condition: isGrid,
      builder: _gridBuilder(products, width, height, cubit),
      feedback: _listBuilder(products, height, cubit),
    );
  }
  Widget _gridBuilder
      (List<HomeProducts> ? products, double width, double height, HomeCubit cubit) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: width / height * 1.35,
        // childAspectRatio: width / height * 0.9, // was 1.07
      ),
      itemBuilder: (context, index) {
        HomeProducts ? product = products?[index];
        return ProductCard(isGrid: cubit.isGrid, name: product!.name!, seller: 'E-Shop', image: product.image!, price: product.price!, id: product.id!, oldPrice: product.oldPrice!, discount: product.discount!);
      },
    );
  }
  ListView _listBuilder(List<HomeProducts>? products, double height, HomeCubit cubit) =>
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products?.length,
        itemBuilder: (context, index) {
          HomeProducts ? product = products?[index];
          return SizedBox(
            height: height * 0.2,
            child: ProductCard(isGrid: cubit.isGrid, name: product!.name!, seller: 'E-Shop', image: product.image!, price: product.price!, id: product.id!, oldPrice: product.oldPrice!, discount: product.discount!),

          );
        },
      );


}
class _BannerBuilder extends StatelessWidget {
  final HomeCubit cubit;
  const _BannerBuilder(
    this.cubit, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      CarouselController _carouselController = CarouselController();
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return Container(
        width: double.infinity,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadiusDirectional.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColorDarker.withOpacity(0.9),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: AppCubit.get(context).isDark? 1:0,
            ),
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CarouselSlider(
                    items: cubit.banners.map((e) {
                      return InkWell(
                        onTap: (){
                          if (e.image != null)
                            navigateTo(context, OfferDetailsScreen(e.image,e.id));
                        },
                        child: Hero(
                          tag: '${e.id}',
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              // banner image
                              Container(
                             width: double.infinity,
                             clipBehavior: Clip.antiAliasWithSaveLayer,
                             decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10.0),
                               color: Colors.transparent,
                             ),
                                  child: Image.network('${e.image != null?e.image:kNoImageFound}', fit: BoxFit.cover,width: width,)),
                              // see offer
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: height * 0.15,
                      autoPlay: true,
                      reverse: false,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.easeInOutCubic,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) => cubit.changeBannerSlide(index),
                    ),
                  ),
                  _bannerPopup(),
                ],
              ),
            ),
            _bannerIndicator(height),
          ],
        ),
      );
    });
  }

  Widget _bannerPopup() => Padding(
    padding: const EdgeInsets.all(2.0),
    child: CircleAvatar(
      backgroundColor: Colors.black45,
      child: CustomPopUpButton(
            popUps: PopUpModel.bannerOptions,
            icon: Icons.more_vert,
            onSelected: (_) => cubit.hideBanners(),
          ),
    ),
  );
   Widget _bannerIndicator(double height) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding:const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black45,
          ),
          child: AnimatedSmoothIndicator(
            effect:  SwapEffect(
              dotHeight: height*0.006 ,
              activeDotColor: kPrimaryColorDarker,
            ),
            activeIndex: cubit.bannerSlideIndex,
            count: cubit.banners.length,
          ),
        ),
      );
}

// SizedBox(
// width: double.infinity,
// child: CupertinoSegmentedControl<int>(
// children: {
// 0:Text('X'),
// 1:Text('XL'),
// 2:Text('s'),
// },
// onValueChanged: (_){},
// ),
// ),

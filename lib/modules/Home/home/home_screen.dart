import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/models/api/banners_model.dart';
import 'package:e_shop/models/api/categories_model.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        PageController _pageController = PageController();
        CategoriesModel ? categories = cubit.categoriesModel;

        CarouselController _carouselController = CarouselController();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //search bar
                 _SearchBar(),
                  YSpace.extreme,
                  // Banner Slider
                  if (cubit.banners.isNotEmpty)
                    _BannerBuilder(cubit, _carouselController,banners: cubit.banners),
                  // categories
                  YSpace.normal,
                  MyConditionalBuilder(
                    condition: cubit.categoriesModel?.status != null , // loading if no categories
                    builder: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: height * 0.1,
                          child: _CategoriesGridBuilder(cubit,model:categories),
                        ),
                      ],
                    ),
                    feedback:  kLoadingFadingCircle ,
                  ),
                  //New Products
                  MyConditionalBuilder(
                    condition: true, //
                    builder: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Popular Products '.toUpperCase(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            PopupMenuButton<dynamic>(
                              iconSize: 20,
                              icon: Icon(FontAwesomeIcons.slidersH),
                              itemBuilder: (context)=>_popUpOptions,),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.1,
                          child: Container(), /// products goes here
                        ),
                      ],
                    ),
                    feedback:  kLoadingFadingCircle ,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: CupertinoSegmentedControl<int>(
                  //       children: {
                  //         0:Text('X'),
                  //         1:Text('XL'),
                  //         2:Text('s'),
                  //       },
                  //       onValueChanged: (_){}),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
class _BannerBuilder extends StatelessWidget {
  final CarouselController carouselController;
  final HomeCubit cubit;
  final List<BannerData> banners;

  const _BannerBuilder(this.cubit, this.carouselController,
      {Key? key, required this.banners})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;

      return Column(
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
                    onTap: () {},/// Go to offer screen
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
              onPageChanged: (index, reason) => cubit.changeBannerSlide(index),
            ),
          ),
          SizedBox(height: height * 0.03),
          AnimatedSmoothIndicator(
            effect: SwapEffect(
              dotHeight: height * 0.004,
              dotWidth: width * 0.04,
              activeDotColor: kPrimaryColorDarker,
            ),
            activeIndex: cubit.bannerSlideIndex,
            count: banners.length,
          ),
        ],
      );
    });
  }
}
class _CategoriesGridBuilder extends StatelessWidget {
  final HomeCubit cubit ;
  final CategoriesModel ? model ;
  const _CategoriesGridBuilder(this.cubit, {Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model!.categoriesData!.dataList!.length,

      itemBuilder: (context,index){
        var item = model?.categoriesData?.dataList?[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            type: MaterialType.canvas, /// check this
            color: AppCubit.get(context).isDark?kPrimaryColorDarker.withOpacity(0.4):kPrimaryColorDarker,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
            elevation: 0.0,
            shadowColor: kPrimaryColor,
            child: MaterialButton(
              padding: EdgeInsets.all(2.0),
              onPressed: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Image.network('${item!.image}')),
                  YSpace.light,
                  FittedBox(child: Text('${item.name?.toUpperCase()}',style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      style:Theme.of(context).textTheme.subtitle2 ,
      itemColor: AppCubit.get(context).isDark?Colors.white38:Colors.black38,
      placeholder: ' Search anything you want !',
    );
  }
}



List <PopupMenuEntry>_popUpOptions = [
  PopupMenuItem(child: Row(
    children: [
      Icon(FontAwesomeIcons.listUl,size: 20.0,),
      XSpace.normal,
      Text('List'),
    ],
  ),),
  PopupMenuItem(child: Row(
    children: [
      Icon(FontAwesomeIcons.th,size: 20.0,),
      XSpace.normal,
      Text('Grid'),
    ],
  ),),
];



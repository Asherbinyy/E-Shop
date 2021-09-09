import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/modules/sort/sort_items_screen.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import '/shared/components/builders/banner_builder.dart';
import '/shared/components/builders/welcome_message_builder.dart';
import '/shared/components/reusable/product/product_item_card.dart';
import '/models/api/home.dart';
import '/shared/cubit/app_cubit.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/modules/landing/landing_screen.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {

        HomeCubit cubit = HomeCubit.get(context);
        var profile = HomeCubit.get(context).profileModel;
        List<HomeProducts>? products = HomeCubit.get(context).homeModel?.data?.products;
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        bool isDark = AppCubit.get(context).isDark;
        CarouselController _carouselController = CarouselController();

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Slider
                if (cubit.banners.isNotEmpty) BannerBuilder(cubit, _carouselController,banners: cubit.banners),
                // Welcome Message
                  WelcomeMessageBuilder(cubit: cubit, profile: profile, isDark: isDark),
                // popular Products
                MyConditionalBuilder(
                  condition: cubit.homeModel?.data != null,
                  builder: _ProductsBuilder(isDark, products: products, width: width, height: height),
                  feedback: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: kLoadingFadingCircle,
                  ),
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
        );
      },
    );
  }
}

class _ProductsBuilder extends StatelessWidget {
  const _ProductsBuilder(
    this.isDark, {
    Key? key,
    required this.products,
    required this.width,
    required this.height,
  }) : super(key: key);

  final bool isDark;
  final List<HomeProducts>? products;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // products
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 10.0,start: 10),
          child: FittedBox(
            child: Text(
              'Popular Products '.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        YSpace.extreme,
        //Filter Search
        Card(
          elevation: 1.0,
          shadowColor: kSecondaryColorDarker.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: ()=>showModalBottomSheet(
                      context: context,
                      builder: (context)=>curvedBottomSheetDecoration(
                        isDark,
                      child: SortItemsScreen(),
                    ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list),
                        XSpace.tiny,
                        Text('Filter'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.sort),
                      XSpace.tiny,
                      Text('Filter : Low'),
                    ],
                  ),
                ),
                Icon(Icons.featured_play_list),
              ],
            ),
          ),
        ),
        // products grid
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: width/height*1,
            // childAspectRatio: width / height * 0.9, // was 1.07
          ),
          itemBuilder: (context, index) {
            return ProductItemCard(isDark, height: height, product: products?[index], width: width);
          },
        ),
      ],
    );
  }
}


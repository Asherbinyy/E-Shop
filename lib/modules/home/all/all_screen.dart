import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/models/app/popup_model.dart';
import 'package:e_shop/modules/sort/sort_items_screen.dart';
import 'package:e_shop/shared/components/builders/product_builder.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/filter_search/filter_search_list_tile.dart';
import 'package:e_shop/shared/components/reusable/popup_menu_button/custom_popup_button.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import '/shared/components/builders/banner_builder.dart';
import '/shared/components/builders/welcome_message_builder.dart';
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

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangeFavouritesSuccessState){
          if (state.changeFavouritesModel?.status==true)
            DefaultDialogue.showSnackBar(context, '${state.changeFavouritesModel?.message}',
                labelColor: AppCubit.get(context).isDark ? Colors.white : Colors.black, dialogueStates: DialogueStates.NONE, isDark: AppCubit.get(context).isDark);
          else DefaultDialogue.showSnackBar(context, '${state.changeFavouritesModel?.message}', dialogueStates: DialogueStates.ERROR,);
        }
      },
      builder: (context, state) {
        bool isDark = AppCubit.get(context).isDark;
        HomeCubit cubit = HomeCubit.get(context);
        var profile = HomeCubit.get(context).profileModel;
        List<HomeProducts>? products =
            HomeCubit.get(context).homeModel?.data?.products;
        CarouselController _carouselController = CarouselController();

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Slider
                if (cubit.banners.isNotEmpty && cubit.isBannerShown)
                  BannerBuilder(cubit, _carouselController,banners: cubit.banners),
                // Welcome Message
                WelcomeMessageBuilder(cubit: cubit, profile: profile, isDark: isDark),
                // popular Products
                MyConditionalBuilder(
                  condition: cubit.homeModel?.data != null,
                  builder: ProductsBuilder(products,showHeaderTitle: true,headerTitle: 'Popular products',isGrid: cubit.isGrid,),
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
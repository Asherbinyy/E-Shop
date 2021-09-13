import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/models/api/categories.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final DataCategoriesData category;
  const CategoryScreen(this.category,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        bool isDark = AppCubit.get(context).isDark;
        double height = MediaQuery.of(context).size.height;
        TextTheme textTheme = Theme.of(context).textTheme;

        return MyConditionalBuilder(
          condition: category.name != null,
          builder: Container(
            // color: Colors.blue.shade900,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categoryImage(height, textTheme, isDark),
                    // ProductsBuilder(cubit, isDark, products: cubit.products)
                  ],
                ),
              ),
            ),
          ),
          feedback: Center(
            child: kLoadingHourGlass,
          ),
        );
      },
    );
  }

  Widget _categoryImage(double height, TextTheme textTheme, bool isDark) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        //image
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: double.infinity,
          height: height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? kPrimaryColorDarker
                    : kPrimaryColorDarker.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Image.asset(
            getCategoryImageUrl(category),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // text
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5.0),
          color: isDark ? Colors.white54 : Colors.black45,
          child: Center(
            child: Text(
              category.name?.toUpperCase() ?? '',
              style: textTheme.overline
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateUsDialog extends StatelessWidget {
  const RateUsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          HomeCubit cubit = HomeCubit.get(context);
          return Hero(
            tag: ValueKey<String>('RateUs'),
            child: Dialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Give us your Feedback'),
                    YSpace.extreme,
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                          EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) =>
                              cubit.rateProduct(rating),
                        ),
                        Spacer(),
                        if (cubit.userRating != null)
                          Text(
                            '(${cubit.userRating})',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: kPrimaryColor),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}

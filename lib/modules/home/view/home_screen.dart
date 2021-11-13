import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/styles/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// REVIEWED
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return MyConditionalBuilder(
          condition: cubit.tabBarData.length > 0 ,
          onBuild: Column(
            children: [
              Expanded(
                child: TabBarView(
                children:
                [
                  ...cubit.tabBarData.map((e) => e.screen),
                ],
        ),
              ),
            ],
          ),
         onError:const Center(child: kLoadingWanderingCubes),
        );
      },
    );
  }
}


import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/modules/landing/landing_screen.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return MyConditionalBuilder(
          condition: cubit.tabBarData.length > 0 ,
          builder: TabBarView(
          children:cubit.tabBarData.map((e) => e.screens).toList(),
        ),
         feedback: Center(child: kLoadingWanderingCubes),
        );
      },
    );
  }
}


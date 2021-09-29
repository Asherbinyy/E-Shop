import '/models/app/faq.dart';
import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('FAQ'),
      child: Scaffold(
        appBar: SecondaryAppBar(
          title:'FAQ',
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(FaqModel.list.length, (index) {
                      return Card(
                        color: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightSecondaryColor,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index+1}. ${FaqModel.list[index].q}',style: Theme.of(context).textTheme.headline6?.copyWith(color: kPrimaryColor),),
                              YSpace.normal,
                              Text('     •  ${FaqModel.list[index].a}  ',style: Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                        ),
                      );
                    },)
                  ,
                ),
                Container(
                  padding:const EdgeInsets.all(8.0),
                  width:double.infinity,
                  child: Card(
                  child: Column(
                    children: [
                      Text('Sending your Question / Feedback help us to improve the app . please make sure to give us your feedback'),
                    ],
                  ),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

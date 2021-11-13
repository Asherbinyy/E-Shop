import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/reusable/dialogue/rate_us_dialog.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/app/faq.dart';
import 'package:e_shop/styles/constants/constants.dart';
import '/shared/components/reusable/tiles/expandable_tile.dart';
import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
/// REVIEWED
class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('FAQ'),
      child: Scaffold(
        appBar: SecondaryAppBar(
          title:'faq'.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  FaqModel.getList.length, (index) {
                  return Card(
                    color: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightSecondaryColor,
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                      width: double.infinity,
                      child: ExpandableListTile(label: '${index+1}. ${FaqModel.getList[index].q}',child:  Text('     •  ${FaqModel.getList[index].a}  ',style: Theme.of(context).textTheme.bodyText2),),

                    ),
                  );
                },),
                SizedBox(
                  width:double.infinity,
                  child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('send_us_questions'.tr(),style: Theme.of(context).textTheme.bodyText2?.copyWith(height: 1.5),),
                        YSpace.normal,
                        OutlinedButton(
                          onPressed: (){
                          navigateTo(context, Scaffold(appBar: SecondaryAppBar(title: 'rate_us'.tr(),),body:const RateUsDialog(),));
                        }, child: Text('send_feedback'.tr().toUpperCase()),),
                      ],
                    ),
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

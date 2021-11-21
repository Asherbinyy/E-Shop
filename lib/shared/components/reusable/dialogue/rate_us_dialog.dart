import 'package:e_shop/modules/layout/layout_screen.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/custom_divider.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';

import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/components/reusable/text_field/default_text_field.dart';
import '/shared/components/reusable/tiles/expandable_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/styles/constants/constants.dart';

/// Reviewed
class RateUsDialog extends StatelessWidget {
  const RateUsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){
          if (state is RateAppSuccessState) {
            navigateToAndFinish(context, LayoutScreen());
            Utils.showSnackBar(context, 'thanks_for_feedback'.tr()+' 🥰', dialogueStates: DialogueStates.SUCCESS);
          }
        },
        builder: (context,state){
          var cubit = LayoutCubit.get(context);
          var isDark = AppCubit.get(context).isDark;
          return Hero(
            tag: ValueKey<String>('RateUs'),
            child: Dialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     Text('give_us_your_rate'.tr(),style: Theme.of(context).textTheme.subtitle2,),
                      YSpace.extreme,
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) =>
                                cubit.rateProduct(rating),
                          ),
                          const Spacer(),
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
                      YSpace.normal,
                      SendUsFeedback(cubit,state,isDark),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: XDivider.semiFaded(),
                      ),
                      YSpace.hard,
                       Text('rate_on_store'.tr(),style: Theme.of(context).textTheme.subtitle2,),
                      YSpace.hard,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child : OutlinedButton.icon(
                              onPressed: (){}, //TODO IN FUTURE 2:
                              label:  FittedBox(
                                fit: BoxFit.scaleDown,
                                  child: Text('apple_store'.tr())),icon:const Icon(FontAwesomeIcons.apple),),
                          ),
                          XSpace.normal,
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: (){},//TODO IN FUTURE 2:
                              label:  FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('google_store'.tr())),icon:const Icon(FontAwesomeIcons.googlePlay),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
class SendUsFeedback extends StatefulWidget {
  final bool isDark ;
  final LayoutCubit cubit ;
  final LayoutStates state;
  const SendUsFeedback(this.cubit,this.state,this.isDark,{Key? key, }) : super(key: key);

  @override
  _SendUsFeedbackState createState() => _SendUsFeedbackState();

}
class _SendUsFeedbackState extends State<SendUsFeedback> {
  var _feedbackController = TextEditingController();

@override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ExpandableListTile(
          primaryColor: Theme.of(context).primaryColor,
          label: 'send_us_a_message'.tr(),
          child: Theme(
            data: Theme.of(context).copyWith(
              hintColor: widget.isDark ? Colors.amber : Colors.amber.shade700,
            ),
            child: DefaultTextField(
              primaryColor: Theme.of(context).primaryColor,
              controller: _feedbackController,
              keyboardType: TextInputType.name,
              isDark: widget.isDark,
              label: 'your_message'.tr(),
              maxLength: 80,
              maxLines: 3,
              prefixIcon: Icons.feedback,
              onSubmitted: (_)=>widget.cubit.rateApp(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child:
        MyConditionalBuilder(
          condition: widget.state is !RateAppLoadingState,
          onBuild:  TextButton(
            child: Text('submit'.tr().toUpperCase()),
            onPressed: ()=> widget.cubit.rateApp(),
          ),
          onError: kLoadingFadingCircle,
        ),
        ),
      ],
    );
  }
}

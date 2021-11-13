import 'dart:async';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/api/user/profile.dart';
import 'package:e_shop/styles/constants/constants.dart';

import '/shared/components/reusable/play_animation/play_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/reusable/buttons/simple_rounded_button.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
/// REVIEWED

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SendVerificationSuccessState) {
          PlayAnimation.animationDialog(context, PlayedAnimationStyle.SUCCESS,msg: state.verifyEmailModel.message);
        }
        if (state is VerifyCodeSuccessState) {
          if (state.verifyCodeModel!.status!)  DefaultDialogue.showSnackBar(context, 'mail_verified_success'.tr(), dialogueStates: DialogueStates.SUCCESS, isDark: AppCubit.get(context).isDark);
        else DefaultDialogue.showSnackBar(context, 'error_try_again'.tr(), dialogueStates: DialogueStates.ERROR, isDark: AppCubit.get(context).isDark);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        var profile = cubit.profileModel!.data!;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyConditionalBuilder(
              condition: cubit.isVerificationSent,
              onBuild: _PinCodeBuilder(cubit,profile),
              onError: _SendVerificationBuilder(cubit, state, profile),
            ),
          ),
        );
      },
    );
  }
}



class _PinCodeBuilder extends StatefulWidget {
  final ProfileData profile;
  final HomeCubit cubit;
  const _PinCodeBuilder(this.cubit,this.profile, {Key? key}) : super(key: key);

  @override
  _PinCodeBuilderState createState() => _PinCodeBuilderState();
}
class _PinCodeBuilderState extends State<_PinCodeBuilder>  {

  var _textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Image.asset(AppCubit.get(context).isDark?kLogoDark:kLogoLight,height: 100,width: 100,),
       const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'email_add_verification'.tr(),
            style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: RichText(
            text: TextSpan(
                text: 'enter_code'.tr(),
                children: [
                  TextSpan(
                      text: widget.profile.email,
                      style:const TextStyle(
                        color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),),
                ],
            style:TextStyle(color: Theme.of(context).textTheme.caption?.color), ),
            textAlign: TextAlign.center,
          ),
        ),
        YSpace.extreme,
        Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 50),
              child: PinCodeTextField(
                textStyle: Theme.of(context).textTheme.headline4,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 4) {
                    return "short_code".tr();
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: kThirdColor,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration:const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset:const Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )),
        ),
        TextButton(
          child: Text('clear'.tr()),
          onPressed: () {
            _textEditingController.clear();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            hasError ? 'fill_all_cells'.tr() : '',
            style:const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        ),
        YSpace.extreme,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'have_not_received_code'.tr(),
            ),
            TextButton(
                onPressed: () => widget.cubit.sendEmailVerification(),
                child: Text(
                  'resend'.tr().toUpperCase(),
                  style: const TextStyle(
                      color: Color(0xFF91D3B3),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
       YSpace.normal,
       /// current text must be modified with the api response
       SimpleRoundedButton(
         color: kThirdColor,
         label: 'verify'.tr(),
         onPressed: (){
           formKey.currentState!.validate();
           // conditions for validating
           if (currentText.length != 4 ) {
             errorController?.add(ErrorAnimationType
                 .shake); // Triggering error shake animation
             setState(() => hasError = true);
           } else {
             setState(
                   () {
                 hasError = false;
                 widget.cubit.verifyCode(code: currentText);
               },
             );
           }
         },
       ),
        YSpace.normal,

      ],
    );
  }
}



class _SendVerificationBuilder extends StatelessWidget {
 final ProfileData profile;
 final HomeCubit cubit;
 final HomeStates state;
  const _SendVerificationBuilder(
      this.cubit,this.state,this.profile,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              AppCubit.get(context).isDark ? kLogoDark : kLogoLight,
            )),
        YSpace.titan,
        Text(
          'send_code'.tr(),
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        YSpace.normal,
        RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
            text: 'confirm_mail'.tr(),
            children: [
              TextSpan(
                style: const TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
                text: profile.email,
              ),
               TextSpan(
                text: 'as_main_mail'.tr(),
              ),
            ],
          ),
        ),
        YSpace.titan,
        MyConditionalBuilder(
          condition: state is! SendVerificationLoadingState,
          onBuild: SimpleRoundedButton(
            label: 'send_verification_code'.tr(),
            onPressed: () => cubit.sendEmailVerification(),
          ),
          onError:const Center(
            child: kLoadingWanderingCubes,
          ),
        ),
      ],
    );
  }
}

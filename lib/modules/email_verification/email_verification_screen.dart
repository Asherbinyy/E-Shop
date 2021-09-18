import 'dart:async';

import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/models/api/user/profile.dart';
import 'package:e_shop/models/api/user/email_verification.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/shared/components/reusable/buttons/simple_rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SendVerificationSuccessState) {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: AppCubit.get(context).isDark
                      ? kDarkSecondaryColor
                      : kLightSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                            (state.verifyEmailModel.status!)
                                ? kSuccessLottie
                                : kFailedLottie,
                            repeat: false,
                            height: 300,
                            width: 300),
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              '${state.verifyEmailModel.message}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: (state.verifyEmailModel.status!)
                                      ? AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.black87
                                      : Colors.red),
                            )),
                      ],
                    ),
                  ),
                );
              }).then((value) {
            // if (state.verifyEmailModel.status!) Navigator.pop(context);
          });
        }
        if (state is VerifyCodeSuccessState) {
          if (state.verifyCodeModel!.status!)  DefaultDialogue.showSnackBar(context, 'Email verified Successfully', dialogueStates: DialogueStates.SUCCESS, isDark: AppCubit.get(context).isDark);
        else DefaultDialogue.showSnackBar(context, 'Something went wrong .. Try again', dialogueStates: DialogueStates.ERROR, isDark: AppCubit.get(context).isDark);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        ProfileData profile = cubit.profileModel!.data!;
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyConditionalBuilder(
              condition: cubit.isVerificationSent,
              builder: _PinCodeBuilder(cubit,profile),
              feedback: _SendVerificationBuilder(cubit, state, profile),
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

  TextEditingController textEditingController = TextEditingController();
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
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Email Address Verification',
            style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: RichText(
            text: TextSpan(
                text: "Enter the code sent to ",
                children: [
                  TextSpan(
                      text: widget.profile.email,
                      style: TextStyle(
                        color: kPrimaryColorDarker,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
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
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: kPrimaryColorDarker.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 4) {
                    return "Code is too short ..";
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
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
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
          child: Text("Clear"),
          onPressed: () {
            textEditingController.clear();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            hasError ? "*Please fill up all the cells properly" : "",
            style: TextStyle(
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
              "Didn't receive the code? ",
            ),
            TextButton(
                onPressed: () => widget.cubit.sendEmailVerification(),
                child: Text(
                  "RESEND",
                  style: TextStyle(
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
         label: 'Verify',
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
          'Send code ',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        YSpace.normal,
        RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
            text: 'Please confirm that you want to use this email ',
            children: [
              TextSpan(
                style: TextStyle(
                    color: kSecondaryColorDarker, fontWeight: FontWeight.bold),
                text: profile.email,
              ),
              const TextSpan(
                text: ' as your account email address ',
              ),
            ],
          ),
        ),
        YSpace.titan,
        MyConditionalBuilder(
          condition: state is! SendVerificationLoadingState,
          builder: SimpleRoundedButton(
            label: 'Send Verification Code',
            onPressed: () => cubit.sendEmailVerification(),
          ),
          feedback: Center(
            child: kLoadingWanderingCubes,
          ),
        ),
      ],
    );
  }
}

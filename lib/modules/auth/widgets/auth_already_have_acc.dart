part of'auth_imports.dart';


enum AuthStyle {LOGIN,REGISTER}

class AuthAlreadyHaveAccount extends StatelessWidget {
  final AuthStyle style ;
  const AuthAlreadyHaveAccount({Key? key,required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText( style==AuthStyle.REGISTER?'already_have_account'.tr():'or_you_can'.tr()),
        CustomTextButton(
          child: CustomText(
            style==AuthStyle.REGISTER? 'sign_in'.tr():'sign_up'.tr(),
            isBold: true,
          isUpperCase: true,
          color: kSecondaryColorLight.withRed(1),
          ),
          onPressed:()=>
          style==AuthStyle.REGISTER?
          navigateToAndFinish(context,const LoginScreen()):
          navigateToAndFinish(context,const RegisterScreen()),
        )
      ],
    );
  }
}

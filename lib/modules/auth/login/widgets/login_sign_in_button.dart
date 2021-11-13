part of 'widgets_login_imports.dart';

class LoginSignInButton extends StatelessWidget {
  const LoginSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <LoginCubit,LoginStates> (
        builder: (context,state){
          final cubit= LoginCubit.get(context);
          return  MyConditionalBuilder(
            condition: state is! LoginLoadingState,
            onBuild: CustomRoundedButton(
              onPressed: () {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.signInWithEmailAndPassword();
                }
              },
              // controller.loginFormKey.currentState?.save();
              // if (controller.loginFormKey.currentState!.validate()){
              //   controller.signInWithEmailAndPassword();
              // },
              elevation: 1.0,
              child: CustomText(
                'sign_in'.tr(),
                isBold: true,
                isUpperCase: true,
                // style: const TextStyle(
                //   color: Colors.white,
                // ),
              ),
            ),
            onError: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        });
  }
}

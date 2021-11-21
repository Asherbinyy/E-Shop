part of 'widgets_register_imports.dart';

class RegisterSignUpButton extends StatelessWidget {
  const RegisterSignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) {
      final cubit = RegisterCubit.get(context);
      return MyConditionalBuilder(
        condition: state is! SignUpLoadingState,
        onBuild: CustomRoundedButton(
          child: Text('sign_up'.tr().toUpperCase()),
          onPressed: () async {
            if (cubit.registerFormKey.currentState!.validate()) {
              await cubit.signUpWithEmailAndPassword();
            }
          },
        ),
        onError: Center(child: kLoadingFadingCircle),
      );
    });
  }
}

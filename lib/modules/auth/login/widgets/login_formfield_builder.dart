part of 'widgets_login_imports.dart';

class LoginFormFieldsBuilder extends StatelessWidget {
  final bool isDark;
  const LoginFormFieldsBuilder(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
      final cubit = LoginCubit.get(context);
      return Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YSpace.hard,

            CustomTextFormField(
              isDark: isDark,
              label: 'email_address'.tr(),
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              controller: cubit.emailController,
              // validator: (value) =>
              // FormValidator.validator(value, fieldName: 'Email'),
              validator: cubit.validator('enter_your_email_address'.tr()),
            ),
            YSpace.hard,
            CustomTextFormField(
              isDark: isDark,
              label: 'password'.tr(),
              prefixIcon: Icons.lock_open_outlined,
              suffixIcon: cubit.suffixIcon(),
              controller: cubit.passwordController,
              keyboardType: TextInputType.visiblePassword,
              // validator: (value) =>
              //     FormValidator.validator(value, fieldName: 'Password'),
              validator: cubit.validator('enter_your_password'.tr()),
              suffixOnChanged: () => cubit.suffixPressed(),
              obscurePassword: cubit.showPassword,
            ),
            YSpace.hard,
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: CustomTextButton(
                primaryColor: isDark ? kLightPrimaryColor : kDarkPrimaryColor,
                child: CustomText(
                  'forgot_password'.tr(),
                  color: kPrimaryColor,
                ),
                onPressed: () =>
                    navigateTo(context, const ForgotPasswordScreen()),
              ),
            ),
           const LoginSignInButton(),
            const LoginRememberMeLisTile(),
          ],
        ),
      );
    });
  }
}

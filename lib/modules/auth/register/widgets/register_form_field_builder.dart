part of 'widgets_register_imports.dart';

class RegisterFormFieldsBuilder extends StatelessWidget {
  final bool isDark;
  const RegisterFormFieldsBuilder(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder <RegisterCubit, RegisterStates>(
            builder: (context, state) {
          final cubit = RegisterCubit.get(context);
          return Form(
            key: cubit.registerFormKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SigningTextField(
                  isPrimary: true,
                  labelText: 'full_name'.tr(),
                  prefixIcon: FontAwesomeIcons.user,
                  controller: cubit.registerNameController,
                  keyboardType: TextInputType.name,
                  validator: cubit.validator('enter_your_name'.tr()),
                ),
                YSpace.normal,
                SigningTextField(
                  isPrimary: true,
                  labelText: 'phone'.tr(),
                  prefixIcon: Icons.phone_outlined,
                  controller: cubit.registerPhoneController,
                  keyboardType: TextInputType.phone,
                  validator: cubit.validator('enter_your_phone'.tr()),
                ),
                YSpace.normal,
                SigningTextField(
                  isPrimary: true,
                  labelText: 'email_address'.tr(),
                  prefixIcon: Icons.email_outlined,
                  prefixIconColor: kPrimaryColorLight.withRed(1),
                  formFieldShadowColor: kPrimaryColorLight.withRed(1),
                  cursorColor: kPrimaryColorLight.withRed(1),
                  iconShadowColor: kPrimaryColorLight.withRed(1),
                  controller: cubit.registerEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: cubit.validator('enter_your_email_address'.tr()),
                ),
                YSpace.normal,
                SigningTextField(
                  isPrimary: false,
                  labelText: 'password'.tr(),
                  prefixIcon: Icons.lock_open_outlined,
                  suffixIcon: cubit.suffixIcon(),
                  suffixIconColor: kSecondaryColorLight.withRed(0),
                  prefixIconColor: kSecondaryColorLight.withRed(0),
                  formFieldShadowColor: kSecondaryColorLight.withRed(0),
                  iconShadowColor: kSecondaryColorLight.withRed(0),
                  cursorColor: kSecondaryColorLight.withRed(0),
                  controller: cubit.registerPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: cubit.validator('enter_your_password'.tr()),
                  suffixPressed: () => cubit.suffixPressed(),
                  obscureText: cubit.showPassword,
                ),
                YSpace.normal,
                SigningTextField(
                  isPrimary: false,
                  labelText: 'confirm_password'.tr(),
                  prefixIcon: Icons.lock_open_outlined,
                  suffixIcon: cubit.suffixIcon(),
                  suffixIconColor: kSecondaryColorLight.withRed(0),
                  prefixIconColor: kSecondaryColorLight.withRed(0),
                  formFieldShadowColor: kSecondaryColorLight.withRed(0),
                  iconShadowColor: kSecondaryColorLight.withRed(0),
                  cursorColor: kSecondaryColorLight.withRed(0),
                  controller: cubit.registerConfirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: cubit.validator('password_match'.tr()),
                  obscureText: cubit.showPassword,
                  suffixPressed: () => cubit.suffixPressed(),
                ),
                YSpace.normal,
              ],
            ),
          );
        }),
        RegisterAgreeWithMe(isDark),
        YSpace.normal,
        const RegisterSignUpButton(),
        XDivider.faded(),
        AuthAlreadyHaveAccount(
          style: AuthStyle.REGISTER,
        ),
      ],
    );
  }
}

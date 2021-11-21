part of 'register_imports.dart';

/// reviewed

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _isDark = AppCubit.get(context).isDark;
    return RegisterWrapper(
      screen: Scaffold(
        body: MainPadding(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              RegisterHeaderBuilder(_isDark),
              RegisterFormFieldsBuilder(_isDark),
            ],
          ),
        ),
      ),
    );
  }
}



// class BackUpRegisterFormFieldsBuilder extends StatelessWidget {
//   final bool isDark;
//   const BackUpRegisterFormFieldsBuilder(this.isDark, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterCubit, RegisterStates>(
//         builder: (context, state) {
//           final cubit = RegisterCubit.get(context);
//           return Form(
//             key: cubit.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 CustomTextFormField(
//                   isDark: isDark,
//                   label: 'full_name'.tr(),
//                   prefixIcon: FontAwesomeIcons.user,
//                   keyboardType: TextInputType.name,
//                   validator: cubit.validator('enter_your_name'.tr()),
//                   controller: cubit.nameController,
//                 ),
//                 YSpace.normal,
//                 CustomTextFormField(
//                   isDark: isDark,
//                   label: 'phone'.tr(),
//                   prefixIcon:Icons.phone_outlined,
//                   keyboardType: TextInputType.phone,
//                   validator:cubit.validator('enter_your_phone'.tr()),
//                   controller: cubit.phoneController,
//                 ),
//                 YSpace.normal,
//                 CustomTextFormField(
//                   isDark: isDark,
//                   label: 'email_address'.tr(),
//                   prefixIcon: Icons.email_outlined,
//                   keyboardType:  TextInputType.emailAddress,
//                   validator:cubit.validator('enter_your_email_address'.tr()),
//                   controller:cubit.emailController,
//                 ),
//                 YSpace.normal,
//                 CustomTextFormField(
//                   isDark: isDark,
//                   label: 'password'.tr(),
//                   prefixIcon:  Icons.lock_open_outlined,
//                   suffixIcon:cubit.suffixIcon() ,
//                   obscurePassword: cubit.showPassword,
//                   suffixOnChanged:  () => cubit.suffixPressed(),
//                   keyboardType: TextInputType.visiblePassword,
//                   validator: cubit.validator('enter_your_password'.tr()),
//                   controller: cubit.passwordController,
//                 ),
//                 YSpace.normal,
//                 RegisterAgreeWithMe(isDark),
//                 YSpace.normal,
//                 const RegisterSignUpButton(),
//                 XDivider.faded(),
//                 AuthAlreadyHaveAccount(
//                   style: AuthStyle.REGISTER,
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }


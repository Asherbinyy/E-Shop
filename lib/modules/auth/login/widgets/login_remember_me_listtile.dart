part of 'widgets_login_imports.dart';

class LoginRememberMeLisTile extends StatelessWidget {
  const LoginRememberMeLisTile( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.grey),
              child: BlocBuilder<LoginCubit,LoginStates>(
                builder: (context,state){
                  final cubit = LoginCubit.get(context);
                  return Checkbox(
                    activeColor: kPrimaryColorLight,
                    value: cubit.isCheckBox,
                    onChanged: (isCheckBox) {
                      cubit.checkBox();
                    });
                },
              ),
            ),
            CustomText.subtitle(
              'remember_me'.tr(),
              isBold: true,
            ),
            CustomTextButton(
              child: CustomText(
                'forgot_password'.tr(),
                color: kPrimaryColorLight.withRed(1),
                isBold: true,
              ),
              onPressed: () =>
                  navigateTo(context, const ChangePasswordScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

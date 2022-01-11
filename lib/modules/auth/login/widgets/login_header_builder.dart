part of 'widgets_login_imports.dart';

class LoginHeaderBuilder extends StatelessWidget {
  final bool isDark;
  const LoginHeaderBuilder(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return ShadedContainer(
      isDark: isDark,
      innerPadding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'AppIcon',
            child: Center(
              child: AuthBrandLogo(
                height: _height * 0.3,
                width: _width * 0.4,
                isDark: isDark,
              ),
            ),
          ),
          Row(
            children: [
              CustomText(
                'welcome_back'.tr(),
                fontSize: 25,
                isBold: true,
              ),
              const Spacer(),
              CustomTextButton(
                child: CustomText(
                  'sign_up'.tr(),
                  fontSize: 16,
                  isBold: true,
                  color: kPrimaryColor,
                ),
                onPressed: () => navigateTo(
                    context, const RegisterScreen()),
              ),
            ],
          ),
          CustomText.subtitle(
            'login_to_your_acc'.tr(),
            isBold: true,
          ),
          YSpace.titan,
        ],
      ),
    );
  }
}

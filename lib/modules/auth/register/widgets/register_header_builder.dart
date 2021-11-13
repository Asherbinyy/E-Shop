part of'widgets_register_imports.dart';

class RegisterHeaderBuilder extends StatelessWidget {
  final bool isDark;
  const RegisterHeaderBuilder(this.isDark, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Hero(
          tag: 'AppIcon',
          child: AuthBrandLogo(
            height: _height * 0.2,
            width: _width * 0.5,
            isDark: isDark,
          ),
        ),
        CustomText(
          'welcome'.tr(),
          isBold: true,
          fontSize: 30,
        ),
        YSpace.normal,
        CustomText.subtitle(
          'create_new_account'.tr(),
          isBold: true,
        ),
        YSpace.hard,
      ],
    );
  }
}

part of 'widgets_login_imports.dart';

class LoginSigningMethodsBuilder extends StatelessWidget {
  const LoginSigningMethodsBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ComingSoonBuilder(
      innerPadding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey.shade400,
                height: 1.5,
                width: width / 5.0,
              ),
              SizedBox(
                width: width / 30.0,
              ),
              CustomText(
                'signing_methods'.tr(),
                fontSize: 13,
              ),
              SizedBox(
                width: width / 30.0,
              ),
              Container(
                color: Colors.grey.shade400,
                height: 1.5,
                width: width / 5.0,
              ),
            ],
          ),
          YSpace.hard,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...SigningMethodsData.getSigningMethods.map(
                (e) => CustomIconButton(
                  tooltip: e.label,
                  iconSize: 30.0,
                  color: e.color,
                  icon: e.icon,
                  onPressed: () {},

                  /// TODO : UPDATE THIS
                ),
              ),
            ],
          ),
          YSpace.titan,
          // AuthAlreadyHaveAccount(),
        ],
      ),
    );
  }
}

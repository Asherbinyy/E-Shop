part of 'login_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDark = AppCubit.get(context).isDark;
    return LoginWrapper(
      screen: Scaffold(
        // backgroundColor: isDark ? kDarkPrimaryColor : Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              LoginHeaderBuilder(isDark),
              LoginFormFieldsBuilder(isDark),
             const LoginSigningMethodsBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

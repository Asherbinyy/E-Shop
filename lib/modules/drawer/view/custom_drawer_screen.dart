part of 'custom_drawer_imports.dart';
///reviewed
class CustomDrawerScreen extends StatelessWidget {
  const CustomDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDrawerWrapper(
      screen: BlocBuilder<LayoutCubit, LayoutStates>(
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          final profile = cubit.profileModel?.data;
          return DrawerScaffold(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DrawerViewProfileWidget(profile: profile),
              if (!cubit.isEmailVerified)DrawerVerifyMail(
                  onTap: () => navigateTo(context, const EmailVerificationScreen(),),),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 10.0),
                child:XDivider.normal(),
              ),
              DrawerMenuOptions(cubit),
            ],
          ),
          );
        },
      ),
    );
  }
}





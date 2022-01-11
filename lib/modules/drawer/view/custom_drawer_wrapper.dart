part of 'custom_drawer_imports.dart';

class CustomDrawerWrapper extends StatelessWidget {
  final Widget screen ;
  const CustomDrawerWrapper({Key? key,required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          if (state.signOutModel.status!) {
            CacheHelper.removeData(TOKEN).then((value) {
              if (value) {
                navigateToAndFinish(context,const LoginScreen());
                Phoenix.rebirth(context);
              }
            });
          } else {
            Utils.showSnackBar(context, state.signOutModel.message!,
                dialogueStates: DialogueStates.ERROR,
                isDark: AppCubit.get(context).isDark);
            navigateBack(context);
          }
        }
        if (state is SignOutErrorState) {
          navigateBack(context);
          Utils.showSnackBar(context, 'something_went_wrong'.tr(),
              dialogueStates: DialogueStates.ERROR,
              isDark: AppCubit.get(context).isDark);
        }
      },
        child:  screen ,
    );
  }
}

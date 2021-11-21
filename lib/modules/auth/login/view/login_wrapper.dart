
part of 'login_imports.dart';

/// Contains all screen wrappers such as BloC Providers , Consumers , .... etc.

// typedef LoginBuilder = Widget Function(BuildContext context,LoginStates state);

class LoginWrapper extends StatelessWidget {
  final Widget screen;
  // final LoginStates state ;
  const LoginWrapper({Key? key, required this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider <LoginCubit> (
      create:(context)=> LoginCubit(),
      child: BlocListener<LoginCubit,LoginStates>(
        listener: (context,state){
          /// In case Status code is 200
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              if (LoginCubit.get(context).isCheckBox) {
                CacheHelper.saveData(TOKEN, state.loginModel.data?.token)
                    .then((value) {
                  if (value) {
                    token = state.loginModel.data?.token;
                    navigateToAndFinish(context,const WelcomeMessageScreen());
                  }
                });
              } else {
                token = state.loginModel.data?.token;
                navigateToAndFinish(context,const WelcomeMessageScreen());
              }
            } else {
              Utils.showSnackBar(context, state.loginModel.message!,
                  dialogueStates: DialogueStates.ERROR,
                  isDark: AppCubit.get(context).isDark);
            }
          }
        },
        child: screen,
      ),
    );
  }
}

part of 'register_imports.dart';

class RegisterWrapper extends StatelessWidget {
  final Widget screen;
  const RegisterWrapper({Key? key,required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          final cubit =  RegisterCubit.get(context);
          /// In case Status code is 200
          if (state is SignUpSuccessState) {
            if (state.registerModel.status!) {
              if (cubit.isCheckBox) {
                CacheHelper.saveData(TOKEN, state.registerModel.data?.token)
                    .then((value) {
                  if (value) {
                    token = state.registerModel.data?.token;
                    navigateToAndFinish(context, LayoutScreen());
                  }
                });
              } else {
                token = state.registerModel.data?.token;
                DefaultDialogue.showSnackBar(context, "You should agree with our Terms and conditions to keep going", dialogueStates: DialogueStates.ERROR);
              }
            } else
              DefaultDialogue.showSnackBar(context, state.registerModel.message!,
                  dialogueStates: DialogueStates.ERROR,
                  isDark: AppCubit.get(context).isDark);
          }

          /// In case Status code isNot 200 (connection lost)

          if (state is SignUpErrorState) {
            cubit.registerPasswordController.clear();
            cubit.registerEmailController.clear();
            cubit.registerNameController.clear();
            cubit.registerPhoneController.clear();
            navigateToAndFinish(context, NoInternetErrorScreen());
          }
        },
        child: screen,
      ),
    );
  }
}

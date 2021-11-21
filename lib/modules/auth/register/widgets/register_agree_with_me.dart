part of 'widgets_register_imports.dart';

class RegisterAgreeWithMe extends StatelessWidget {
  final bool isDark;
  const RegisterAgreeWithMe(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: FittedBox(
        // fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.grey),
              child: BlocBuilder<RegisterCubit, RegisterStates>(
                builder: (context, state) {
                  final cubit = RegisterCubit.get(context);
                  return Checkbox(
                    activeColor: kSecondaryColorLight.withRed(1),
                    value: cubit.isCheckBox,
                    onChanged: (isCheckBox) => cubit.checkBox(),
                  );
                },
              ),
            ),
            Text('i_agree_with'.tr(),
                style: Theme.of(context).textTheme.subtitle2),
            CustomTextButton(
              child: CustomText('terms_and_conditions'.tr(),
                  isBold: true, color: kSecondaryColorLight.withRed(0)),
              onPressed: () {
                Platform.isIOS
                    ? Utils.showIOSModalSheet(context,
                        title: 'terms_and_conditions'.tr(),
                        actions: [
                          TextButton(
                              onPressed: () => navigateBack(context),
                              child: Text('i_understand'.tr())),
                        ],
                        message: 'dummy_text'.tr())
                    : Utils.showAndroidBottomSheet(context,
                        child: CurvedBottomSheetContainer(
                          padding: const EdgeInsets.all(16.0),
                          isDark: isDark,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('dummy_text'.tr()),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: TextButton(
                                    onPressed: () => navigateBack(context),
                                    child: Text('i_understand'.tr())),
                              ),
                            ],
                          ),
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

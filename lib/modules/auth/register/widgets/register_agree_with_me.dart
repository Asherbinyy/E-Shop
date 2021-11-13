
part of'widgets_register_imports.dart';

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
              child: Checkbox(
                  activeColor: kSecondaryColorLight.withRed(1),
                  value: RegisterCubit.get(context).isCheckBox,
                  onChanged: (isCheckBox) {
                    RegisterCubit.get(context).checkBox();
                  }),
            ),
            Text('i_agree_with'.tr(),
                style: Theme.of(context).textTheme.subtitle2),
            TextButton(
              child: Text(
                'terms_and_conditions'.tr(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColorLight.withRed(0)),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return curvedBottomSheetDecoration(
                        isDark,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
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
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

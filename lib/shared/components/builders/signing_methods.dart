import '/../models/app/signing_methods.dart';
import '/../shared/components/reusable/spaces/spaces.dart';
import '/../styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum SigningMethodStyle {LOGIN,REGISTER}
class SigningMethods extends StatelessWidget {
final SigningMethodStyle style;
final VoidCallback onPressed;
  const SigningMethods(this.style,{Key? key,required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

        return Column(
          children: [
            SizedBox(
              height: height / 40.0,
            ),
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
                Text(
                  'signing_methods'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2?.copyWith(fontSize: 13),
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
            SizedBox(
              height: height / 30.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...SigningMethodsModel.getList.map((e) =>  IconButton(
                  icon: Tooltip(
                    message: e.name,
                    child: Icon(
                      e.icon,
                      semanticLabel: e.name,
                      color: e.color,
                      size:30.0,
                    ),
                  ),
                  onPressed: e.onPressed,
                )),
              ],
            ),
            YSpace.titan,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'already_have_account'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                ),
                TextButton(
                  child: Text(
                    style==SigningMethodStyle.REGISTER ?
                    'sign_in'.tr() :
                    'sign_up'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                        color: kSecondaryColorLight.withRed(1),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: onPressed,
                )
              ],
            ),
          ],
        );

  }
}

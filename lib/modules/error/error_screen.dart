import '/modules/login/login_screen.dart';
import '/shared/components/methods/navigation.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// REVIEWED
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
             Image.asset(
              kNoConnectionImage,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 30,
              bottom: 50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: ()=> navigateToAndFinish(context, const LoginScreen()),
                    child: Text('retry'.tr().toUpperCase(),
                    ),
                ),
              ),
            )
          ],
        ),
      );
  }
}

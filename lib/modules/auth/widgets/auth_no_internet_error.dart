part of'auth_imports.dart';
/// REVIEWED
class NoInternetErrorScreen extends StatelessWidget {
  const NoInternetErrorScreen({Key? key}) : super(key: key);
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

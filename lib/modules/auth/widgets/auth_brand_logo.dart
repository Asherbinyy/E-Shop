
part of'auth_imports.dart';
class AuthBrandLogo extends StatelessWidget {
  const AuthBrandLogo({
    Key? key,
     this.isDark=false,
   this.height=100,
    this.width=100,
  }) : super(key: key);

  final bool isDark;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height,
      width: width,
      child: Image.asset(isDark ? kLogoDark : kLogoLight),
    );
  }
}

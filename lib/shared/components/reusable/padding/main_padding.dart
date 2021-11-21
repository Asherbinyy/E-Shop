import 'package:flutter/cupertino.dart';

class MainPadding extends StatelessWidget {
  final Widget? child;
  const MainPadding({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.all(20.0),
      child: child,
    );
  }
}
class SecondaryPadding extends StatelessWidget {
  final Widget? child;
  const SecondaryPadding({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

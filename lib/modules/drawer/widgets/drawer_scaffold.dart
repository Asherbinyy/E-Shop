part of 'widgets_custom_drawer_imports.dart';

class DrawerScaffold extends StatelessWidget {
  final Widget child ;
  const DrawerScaffold({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

part of 'widgets_search_imports.dart';

class SearchScaffold extends StatelessWidget {
  final Widget? child;
  final Widget? leading;
  const SearchScaffold({Key? key, required this.child, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'.tr()),
        leading: leading,
      ),
      body: child,
    );
  }
}

part of 'widgets_search_imports.dart';


class SearchNoItemFound extends StatelessWidget {
  const SearchNoItemFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(
            kEmptySearchLottie,
            reverse: false,
          ),
          YSpace.extreme,
          Center(
            child: Text(
              'no_search_content'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

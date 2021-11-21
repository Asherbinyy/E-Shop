part of 'faq_imports.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('FAQ'),
      child: Scaffold(
        appBar: SecondaryAppBar(
          title: 'faq'.tr(),
        ),
        body: SecondaryPadding(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: const AlwaysScrollableScrollPhysics()),
            children: [
              ...List.generate(
                FaqData.getList.length,
                (index) {
                  return FaqQuestionsCard(index);
                },
              ),
             const FaqSendFeedBackButton(),
            ],
          ),
        ),
      ),
    );
  }
}



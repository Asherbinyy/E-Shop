part of 'widgets_faq_imports.dart';

class FaqSendFeedBackButton extends StatelessWidget {
  const FaqSendFeedBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                'send_us_questions'.tr(),
                textHeight: 1.5,
              ),
              YSpace.normal,
              OutlinedButton(
                onPressed: () {
                  navigateTo(
                      context,
                      Scaffold(
                        appBar: SecondaryAppBar(
                          title: 'rate_us'.tr(),
                        ),
                        body: const RateUsDialog(),
                      ));
                },
                child: CustomText(
                  'send_feedback'.tr(),
                  isUpperCase: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

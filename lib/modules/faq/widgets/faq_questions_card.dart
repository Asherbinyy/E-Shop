part of 'widgets_faq_imports.dart';

class FaqQuestionsCard extends StatelessWidget {
  final int index ;
  const FaqQuestionsCard(this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppCubit.get(context).isDark
          ? kDarkSecondaryColor
          : kLightSecondaryColor,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 10.0),
        width: double.infinity,
        child: ExpandableListTile(
          label: '${index + 1}. ${FaqData.getList[index].q}',
          child: CustomText('     •  ${FaqData.getList[index].a}  ',
            color: AppCubit.get(context).isDark?Colors.white:Colors.black87,
              ),
        ),
      ),
    );
  }
}

import '/shared/cubit/app_cubit.dart';
import '/layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/app/popup_model.dart';
import '/modules/sort/sort_items_screen.dart';
import '/shared/components/reusable/popup_menu_button/custom_popup_button.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/styles/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class FilterSearchListTile extends StatelessWidget {
  const FilterSearchListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context){
         bool isDark = AppCubit.get(context).isDark;
      return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeCubit cubit =HomeCubit.get(context);
        return Card(
          elevation: 1.0,
          shadowColor: kSecondaryColorDarker.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: ()=>showModalBottomSheet(
                      context: context,
                      builder: (context)=>curvedBottomSheetDecoration(
                        isDark,
                        child: SortItemsScreen(),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list),
                        XSpace.tiny,
                        Text('Filter'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.sort),
                      XSpace.tiny,
                      Text('Filter : Low'),
                    ],
                  ),
                ),
                CustomPopUpButton(
                  popUps: PopUpModel.productOptions,
                  icon: Icons.featured_play_list,
                  onSelected: (value)=>cubit.changeViewSelection(value),
                ),
              ],
            ),
          ),
        );
      },
    );
     });
    }
}

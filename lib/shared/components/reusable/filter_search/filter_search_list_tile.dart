import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/components/reusable/container/curved_bottom_sheet_container.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/app/pop_up_model.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../modules/sort/view/sort_items_screen.dart';
import '/shared/components/reusable/popup_menu_button/custom_popup_button.dart';

class FilterSearchListTile extends StatelessWidget {
  const FilterSearchListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context){
         bool isDark = AppCubit.get(context).isDark;
      return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        LayoutCubit cubit =LayoutCubit.get(context);
        return Card(
          elevation: 1.0,
          shadowColor: kSecondaryColor.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: ()=>showModalBottomSheet(
                      context: context,
                      builder: (context)=>CurvedBottomSheetContainer(
                       isDark: isDark,
                        child: SortItemsScreen(cubit),
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
                  iconColor: isDark?Colors.white:Colors.black87,
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

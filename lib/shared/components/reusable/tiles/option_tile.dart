import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class OptionListTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isBackgroundColor;
  final VoidCallback? onPressed;
  const OptionListTile(
      {Key? key,
        this.isBackgroundColor = false,
        this.onPressed,
        required this.label,
        required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: null,
      color: (isBackgroundColor)
          ? (AppCubit.get(context).isDark ? Colors.grey[850] : Colors.grey[100])
          : (null),
      elevation: 0.0,
      padding:const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorDark ,
              child: Icon(icon,color: Colors.white,),
            ),
            XSpace.extreme,
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColorDark),
            ),
          ],
        ),
      ),
    );
  }
}

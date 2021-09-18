import '/shared/components/reusable/spaces/spaces.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableListTile extends StatelessWidget {
  final String label;
  final IconData ? icon;
  final Widget? child;
  final VoidCallback? onPressed;

  const ExpandableListTile(
      {Key? key,
        this.child,
        this.onPressed,
        required this.label,
         this.icon,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      padding: const EdgeInsets.all(8.0),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconColor: Theme.of(context).primaryColorDark,
          iconSize: 18,
        ),
        header: Row(
          children: [
          if (icon != null)  CircleAvatar(
              child: Icon(icon,color: Colors.white,),
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
         if (icon != null) XSpace.extreme,
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColorDark),
            ),
          ],
        ),
        collapsed: Visibility(
          visible: false,
          child: Text(''),
        ),
        expanded: child ?? Container(),
      ),
    );
  }
}

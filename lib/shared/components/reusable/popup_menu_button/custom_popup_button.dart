import '/models/app/popup_model.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The popUp values are  always the label .. also initial value is the first label in the list
class CustomPopUpButton extends StatelessWidget {
  final List<PopUpModel> popUps ;
  final IconData icon ;
  final String ? initialValue ;
  final PopupMenuItemSelected<dynamic>? onSelected;

  const CustomPopUpButton({Key? key,required this.popUps, this.onSelected,this.icon=FontAwesomeIcons.slidersH, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: initialValue,
      iconSize: 20,
      onSelected: onSelected,
      icon: Icon(
        icon,
      ),
      itemBuilder: (context) => popUps.map((e) {
        return PopupMenuItem<String>(
          value: e.label,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  e.icon,
                  size: 20.0,
                ),
                XSpace.normal,
                Text(e.label,style: Theme.of(context).textTheme.bodyText2,),
              ],
            ),
          ),
        );
      },).toList(),
    );
  }
}

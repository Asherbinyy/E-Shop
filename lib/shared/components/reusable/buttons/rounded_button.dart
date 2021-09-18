import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledColor;
  final Color? color;
  final IconData? icon;
  final ImageProvider? image;
  final String label;
  final VoidCallback? onPressed;
  final double spacing;
  final bool isImage;
  final bool isIcon;
  final bool isDisabled;
  RoundedButton({
    Key? key,
    this.backgroundColor = kPrimaryColorDarker,
    this.disabledColor = Colors.white70,
    this.disabledBackgroundColor = Colors.grey,
    this.color = Colors.white,
    this.icon,
    this.image,
    this.isImage = false,
    this.isIcon = false,
    this.isDisabled = false,
    this.spacing = 15.0,
    this.onPressed,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        Color ? _backgroundColor ;
        Color ? _color ;
        if (isDisabled){
          _backgroundColor = disabledBackgroundColor ;
          _color = disabledColor;
        }
        else {
          _backgroundColor=backgroundColor;
          _color=color;
        }
        return IgnorePointer(
          ignoring: isDisabled,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: _backgroundColor,
              elevation: 3,
              child: MaterialButton(
                child: (isImage == true || isIcon == true)
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isImage
                        ? Image(
                      image: image!,
                      height: 30,
                      width: 30,
                    )
                        : Icon(icon, color: _color),
                    SizedBox(width: spacing),
                    Text(label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: _color),
                    ),
                  ],
                )
                    : Text(
                  label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: _color),
                ),
                onPressed: onPressed,
              ),
            ),
          ),
        );
      }
    );
  }
}

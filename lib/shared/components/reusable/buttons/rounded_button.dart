import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';

// basic configurations
abstract class _MyRoundedButton extends StatelessWidget {}

class RoundedButton extends _MyRoundedButton {

  final Widget child;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledColor;
  final Color? color;
  final VoidCallback? onPressed;
  final bool isDisabled;
  RoundedButton({
    Key? key,
    this.backgroundColor = kPrimaryColor,
    this.disabledBackgroundColor = Colors.black12,
    this.disabledColor = Colors.grey,
    this.color = Colors.white,
    this.onPressed,
    required this.child,
    this.isDisabled = false,
  }) : super();
  factory RoundedButton.icon({
    /// new
    required final String label,
    required final IconData icon,
    final double ? spacing,
    /// super
    final Color? backgroundColor=kPrimaryColor,
    final Color? disabledBackgroundColor=Colors.black12,
    final Color? disabledColor=Colors.white70,
    final Color? color=Colors.white,
    final VoidCallback? onPressed,
    final bool isDisabled=false,
  }) => RoundedButton(
       onPressed: onPressed,
      isDisabled: isDisabled,
      color: color,
      disabledColor: disabledColor,
      disabledBackgroundColor: disabledBackgroundColor,
      backgroundColor: backgroundColor,
      child: Builder(
        builder: (context) {
          Color? _color;
          if (isDisabled) {
            _color = disabledColor;
          } else {
            _color = color;
          }
          return _RoundedButtonWithIcon(
            color: _color,
            label: label,
            icon: icon,
            spacing: spacing,
          );
        }
      ),
  );
  factory RoundedButton.image({
    /// new
    required final String label,
    required final ImageProvider image,
    final double spacing=15.0,
    /// super
    final Color? backgroundColor=kPrimaryColor,
    final Color? disabledBackgroundColor=Colors.black12,
    final Color? disabledColor=Colors.white70,
    final Color? color=Colors.white,
    final VoidCallback? onPressed,
    final bool isDisabled=false,
  }) => RoundedButton(
    onPressed: onPressed,
    isDisabled: isDisabled,
    color: color,
    disabledColor: disabledColor,
    disabledBackgroundColor: disabledBackgroundColor,
    backgroundColor: backgroundColor,
    child: Builder(
        builder: (context) {
          Color? _color;
          if (isDisabled) {
            _color = disabledColor;
          } else {
            _color = color;
          }
          return _RoundedButtonWithImage(
            label: label,
            image: image,
            color: _color,
            spacing: spacing,
          );
        }
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Color? _backgroundColor;
      Color? _color;
      if (isDisabled) {
        _backgroundColor = disabledBackgroundColor;
        _color = disabledColor;
      } else {
        _backgroundColor = backgroundColor;
        _color = color;
      }
      return IgnorePointer(
        ignoring: isDisabled,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            onTap: onPressed,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: _backgroundColor,
              elevation: isDisabled ? 0 : 3,
              child: MaterialButton(
                textColor: _color,
                child:child,
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _RoundedButtonWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color ?color ;
  final double? spacing;

  const _RoundedButtonWithIcon(
      {Key? key, required this.label, required this.icon, this.spacing=15.0, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        SizedBox(width: spacing),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button!.copyWith(color: color),
        ),
      ],
    );
  }
}
class _RoundedButtonWithImage extends StatelessWidget {
  final String label;
  final ImageProvider image;
  final Color ?color ;
  final double? spacing;

  const _RoundedButtonWithImage(
      {Key? key, required this.label, required this.image, this.spacing=15.0, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: image,width: 50,height: 50,),
        SizedBox(width: spacing),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button!.copyWith(color: color),
        ),
      ],
    );
  }
}


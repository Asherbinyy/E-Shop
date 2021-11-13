import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';

class ShadedContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Color? shadowColor;
  final bool isDark;
  final EdgeInsetsGeometry innerPadding;
 final ImageProvider ? image;
  /// Creates a Container with a shadowColor and simple decoration
  const ShadedContainer(
      {Key? key,
        this.child,
        this.color,
        required this.isDark,
        this.image,
        this.shadowColor,
        this.innerPadding= const EdgeInsets.all(8.0),
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _shadowColor =
        shadowColor ?? (isDark ? Colors.white10 : Colors.black12);
    return Container(
      decoration: BoxDecoration(
        image:image!=null ? DecorationImage(image:image!):null,
        color: color ?? (isDark ? kDarkPrimaryColor : kLightPrimaryColor),
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withOpacity(0.01),
            offset: const Offset(-2, 0),
            blurRadius: 7,
          ),
          BoxShadow(
            color: _shadowColor.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: innerPadding,
        child: child,
      ),
    );
  }
}

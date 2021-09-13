import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SingleProductImagePreviewer extends StatelessWidget {

  final String ? image;

  const SingleProductImagePreviewer(this.image,{Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backwardsCompatibility: false,
      ),
      body:Hero(
        tag: '$image',
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: AppCubit.get(context).isDark?kDarkPrimaryColor:kLightSecondaryColor,
          ),
          imageProvider: NetworkImage('$image'), //$featureImage
        ),
      ),
    );
  }
}

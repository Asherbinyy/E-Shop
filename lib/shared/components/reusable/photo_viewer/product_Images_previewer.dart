import '/shared/components/builders/myConditional_builder.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageController _pageController = PageController();

class ProductImagesPreviewer extends StatelessWidget {
  final List <String> ? images;
  const ProductImagesPreviewer({required this.images,Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      ),
      body: MyConditionalBuilder(
        condition:  images?.length!=0,
        builder: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                  itemCount: images?.length,
                  itemBuilder: (context,index){
                return PhotoView(
                  backgroundDecoration: BoxDecoration(),
                  imageProvider: NetworkImage('${images?[index]}'), //$featureImage
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SmoothPageIndicator(
                 controller: _pageController,
                count: images!.length,
                effect: JumpingDotEffect(
                  activeDotColor: kPrimaryColor,
                   paintStyle: PaintingStyle.fill,
                  dotColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
        feedback: kLoadingWanderingCubes,
      ),
    );
  }
}


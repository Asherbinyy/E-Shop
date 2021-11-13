import 'package:e_shop/services/methods/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class OfferDetailsScreen extends StatelessWidget {
  final String ? offerImage;
  final int ? imageId;
  const OfferDetailsScreen(
    this.offerImage,
      this.imageId,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$imageId',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('offer_details'.tr()),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PhotoView(
              backgroundDecoration: BoxDecoration(),
              imageProvider: NetworkImage('$offerImage'),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 50.0),
              child: ElevatedButton(
                child: Text('view_offer_details'.tr()),
                onPressed: ()=> launchURL('https://stackoverflow.com/questions/63625023/flutter-url-launcher-unhandled-exception-could-not-launch-youtube-url-caused-b'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

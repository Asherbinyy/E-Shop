import 'package:e_shop/shared/components/methods/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OfferDetailsScreen extends StatelessWidget {
  final String ? offerImage;
  const OfferDetailsScreen(
    this.offerImage, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Offer Details'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PhotoView(
            backgroundDecoration: BoxDecoration(),
            imageProvider: NetworkImage('$offerImage'),
          ),
          ElevatedButton(child: Text('View Offer'),
            onPressed: ()=>
                launchURL('https://www.youtube.com/watch?v=qYxRYB1oszw'),
          )
        ],
      ),
    );
  }
}

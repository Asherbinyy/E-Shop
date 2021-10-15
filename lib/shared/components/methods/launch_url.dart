import 'package:url_launcher/url_launcher.dart';
/// reviewed

Future launchURL (String url,{bool inApp=false}) async {

   if (await canLaunch(url)){
      await launch(
         url,
         forceSafariVC:inApp,
         forceWebView: inApp,
         enableJavaScript: true,
      ) ;
   }

}


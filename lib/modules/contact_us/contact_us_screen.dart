import 'package:e_shop/models/app/developer_info.dart';
import 'package:e_shop/models/app/signing_methods.dart';
import 'package:e_shop/shared/components/methods/launch_url.dart';
import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/flip_card/flipping_card.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
/// REVIEWED
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'contact_us'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // reverse: true,
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                  tag: ValueKey<String>('Contact_Us'),
                  child:  _SectionText('about'.tr())),
              YSpace.normal,
              Text(
                'about_app'.tr(),
                style:
                    Theme.of(context).textTheme.bodyText2?.copyWith(height: 1.5),
              ),
              YSpace.normal,
              RoundedButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text('our_licence'.tr().toUpperCase()),
                onPressed: () => DefaultDialogue.showMyAboutDialog(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: XDivider.semiFaded(height: 0.5),
              ),
             const _MeetDeveloper(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetDeveloper extends StatelessWidget {
  const _MeetDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionText('meet_developer'.tr()),
        YSpace.normal,
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage(kDeveloper),
              ),
              YSpace.normal,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   _SectionText('developer_name'.tr()),
                  XSpace.normal,
                   Image.asset(kHiImage,width: 25,height: 25,),
                ],
              ),
              YSpace.normal,
              const _DeveloperInfo(),
              YSpace.normal,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...SitesLinksModel.getDeveloperLinks.map((e) =>  IconButton(
                    icon: Tooltip(
                      message: e.name,
                      child: Icon(
                        e.icon,
                        semanticLabel: e.name,
                        color: e.color,
                        size:30.0,
                      ),
                    ),
                    onPressed: ()=>launchURL(e.link,inApp: true),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeveloperInfo extends StatelessWidget {
  const _DeveloperInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...DeveloperInfo.getInfo.map((e) =>  FlippingCard(
          front: _FrontCardItem(icon: e.icon,label:e.label ),
          back:_BackCardItem(label: e.body,),
        ),),
      ],
    );
  }
}

class _SectionText extends StatelessWidget {
  final String label;
  const _SectionText(
    this.label, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
class _FrontCardItem extends StatelessWidget {
  final String label ;
  final IconData? icon;
  const _FrontCardItem({Key? key, this.icon, this.label=''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                XSpace.normal,
                Text(label,style: const TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _BackCardItem extends StatelessWidget {
  final String label;
  const _BackCardItem({Key? key, this.label=''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child:
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SelectableText(
              label,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
            ),
          )
        ),
      ),
    );
  }
}


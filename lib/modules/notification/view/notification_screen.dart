import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey<String>('Notification'),
      child: Scaffold(
        appBar: SecondaryAppBar(title: 'Notification Screen'),
        body: Column(
          children: [
            Center(child: Text('Notification Screen')),
          ],
        ),
      ),
    );
  }
}
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

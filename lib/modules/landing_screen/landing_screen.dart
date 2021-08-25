import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static String id = 'LandingScreen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:SweepGradient(
            colors: [
              Color(0xff124B56),
              Color(0xff101918),
            ],
            center: Alignment.bottomRight,
            startAngle: 1,
            endAngle: 20
          ),
        ),

      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _GetStarted(_theme)),
            ],
          ),
        ),
        // body: ,
      ),
    );
  }
}
class _GetStarted extends StatelessWidget {
  final ThemeData theme ;
  const _GetStarted(this.theme,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: height * 0.0008,
                    color: kDarkThirdColor,
                  ),
                )),
            Expanded(
              child: Text(
                'Get Started ',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: height * 0.0008,
                    color: kDarkThirdColor,
                  ),
                )),
          ],
        ),
        SizedBox(
          height: height * 0.12,
        ),
        Expanded(child: Placeholder()),
        SizedBox(
          height: height * 0.12,
        ),
        OutlinedButton(
          onPressed: () {},
          child: Text('Continue'),
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width * 0.3, height * 0.06),
          ),
        ),
    ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// require Shimmer package

//constants
const Color _shimmerBaseColor = Colors.grey;
const Color _shimmerHighlightColor = Colors.white70;
const Color _boxColor = Colors.grey;

const double _pagePadding = 10.0;
const double _inBetweenPadding = 6.0;

Widget _item() {
  return Padding(
    padding: const EdgeInsets.all(_pagePadding),
    child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: _boxColor,
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: _boxColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: _inBetweenPadding),
                        child: Container(
                          color: _boxColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: _inBetweenPadding),
                        child: Container(
                          color: _boxColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: _inBetweenPadding),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: _boxColor,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Visibility(
                                visible: false,
                                child: Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ShopShimmerBuilder extends StatelessWidget {
  final bool enabled;
  const ShopShimmerBuilder({Key? key, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor,
      highlightColor: _shimmerHighlightColor,
      enabled: enabled,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              10,
              (index) => _item(),
            ),
          ),
        ),
      ),
    );
  }
}

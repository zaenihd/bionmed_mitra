import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridWidget extends StatelessWidget {
  GridWidget({
    Key? key,
    required this.crossAxisC,
    required this.crossAxisS,
    required this.mainAxisE,
    required this.mainAxisS,
    required this.itemCount,
    this.subtitle,
    required this.widget,
  }) : super(key: key);

  double crossAxisS;
  int crossAxisC;
  double mainAxisE;
  double mainAxisS;
  String? subtitle;
  int itemCount;
  Widget Function(BuildContext, int) widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisC,
            crossAxisSpacing: crossAxisS,
            mainAxisExtent: mainAxisE,
            mainAxisSpacing: mainAxisS),
        itemBuilder: widget
            );
  }
}
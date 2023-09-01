import 'package:bionmed/app/widget/txt/text.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

class HeaderLengkapiDataHospital extends StatelessWidget {
  HeaderLengkapiDataHospital({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.stepper,
  }) : super(key: key);

  String imageUrl, title, subtitle, stepper;

  get bold => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl),
        const SizedBox(
          height: 10.0,
        ),
        Txt(size: 16,
          text: title,
          weight: bold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 14.0,
        ),
        Text(
          subtitle,
          style: subtitleTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30.0,
        ),
        Image.asset(stepper),
      ],
    );
  }
}

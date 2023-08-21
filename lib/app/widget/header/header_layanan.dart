import 'package:flutter/material.dart';

import '../../../theme.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
   HeaderWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  String imageUrl;
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imageUrl),
        const SizedBox(width: 12,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                  fontWeight: bold, fontSize: 16),
            ),
            const SizedBox(height: 8,),
            SizedBox(
                width: Get.width / 1.8,
                child: Text(
                  subtitle,
                  style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 11,
                      color: subtitleColor),
                )),
          ],
        )
      ],
    );
  }
}
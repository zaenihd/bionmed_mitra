// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

// ignore: must_be_immutable
class CarouselBanner extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  String? imageUrl;
   CarouselBanner({
    Key? key,
    this.data,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2 - 5),
      // padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: AppColor.bluePrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('assets/images/banner$imageUrl.png'), fit: BoxFit.cover)),
    );
  }
}

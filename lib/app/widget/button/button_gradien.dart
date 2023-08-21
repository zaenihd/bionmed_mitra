import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme.dart';
import '../../constant/colors.dart';

// ignore: must_be_immutable
class ButtomGradient extends StatelessWidget {
   ButtomGradient({super.key,
  required this.label,
  required this.onTap,
  this.color,
  this.margin
  });

  String label;
  Function() onTap;
  Color? color;
  double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(24),
      margin:  EdgeInsets.symmetric(horizontal : margin ?? 24),

      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        gradient: AppColor.gradient1,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            // ignore: deprecated_member_use
            primary: Colors.transparent,
            // ignore: deprecated_member_use
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
        child: Text(
          label,
          style: whiteTextStyle.copyWith(fontWeight: bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
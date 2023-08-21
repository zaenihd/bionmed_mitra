import 'package:flutter/material.dart';

import '../../../theme.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ButtonPrimary extends StatelessWidget {
   ButtonPrimary({
    Key? key,
    required this.title,
    this.navigation = true,
    required this.onPressed,
    this.color,
    this.marginLeft,
    this.marginRight,
    this.backgroundColor,
  }) : super(key: key);

  String title;
  Function() onPressed;
  bool navigation;
  double? marginLeft;
  double? marginRight;
  Color? backgroundColor;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(left : marginLeft??  24, right:marginRight ??24,),
      height: 50,
      width: Get.width ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: ElevatedButton(
            onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor?? buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Text(
          title,
          
          style: whiteTextStyle.copyWith(fontWeight: bold, color: color ?? Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
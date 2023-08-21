import 'package:flutter/material.dart';

import '../../../theme.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ButtonCostum extends StatelessWidget {
   ButtonCostum({
    Key? key,
    required this.title,
    this.navigation = true,
    required this.onPressed,
    required this.color
  }) : super(key: key);

  String title;
  Function() onPressed;
  bool navigation;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left :24, right: 24,),
      height: 45,
      width: Get.width ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: ElevatedButton(
            onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontWeight: bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
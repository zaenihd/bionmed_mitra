import 'package:flutter/material.dart';

import '../../constant/colors.dart';


AppBar appbarGradient(String title){
  return AppBar(
    title: Text(title),
    elevation: 0.0,
    centerTitle: false,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: AppColor.gradient1,
      ),
    ),
  );
}

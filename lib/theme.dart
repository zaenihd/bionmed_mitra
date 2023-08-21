import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color? buttonColor = const Color(0xffB6B6B6);
Color? blueColor = const Color(0xff2B95DD);
Color? textFieldC = const Color(0xffF9F9F9);
Color? subtitleColor= const Color(0xff555555);
Color? backgroundColorC= Colors.white;
Color? greenColor= const Color(0xff0B9444);
Color? yellowColor= const Color(0xffFFBC26);
Color? whiteColor =  Colors.white;
Color? greyColor = const Color(0xff7C7C7C);
Color? blackColor =  Colors.black;

TextStyle blackTextStyle = GoogleFonts.ubuntu(color: Colors.black);
TextStyle greyTextStyle = GoogleFonts.ubuntu(color: const Color(0xff7C7C7C));
TextStyle blueTextStyle = GoogleFonts.ubuntu(color: const Color(0xff2B95DD));
TextStyle whiteTextStyle = GoogleFonts.ubuntu(color: Colors.white);
TextStyle greenTextStyle = GoogleFonts.ubuntu(color: greenColor);
TextStyle subtitleTextStyle = GoogleFonts.ubuntu(color: subtitleColor);


FontWeight light = FontWeight.w300;
FontWeight normal = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

//GRADIENT
   const LinearGradient gradient1 = LinearGradient(colors: [
    Color(0xFF2B88D9),
    Color(0XFF26E0F5),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

   const LinearGradient gradient2 = LinearGradient(colors: [
    Color(0xFF2B88D9),
    Color(0XFF26E0F5),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
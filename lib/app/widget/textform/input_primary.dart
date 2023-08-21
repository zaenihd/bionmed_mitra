import 'package:flutter/material.dart';

import '../../../theme.dart';

// ignore: must_be_immutable
class InputText extends StatelessWidget {
   InputText({super.key, 
   required this.color,
  required this.label,
  required this.border,
  required this.maxLines,
  });

  String label;
  Color color;
  BorderSide border;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      
      // expands: true,
      minLines: 1,
      maxLines:maxLines,
                      // keyboardType: TextInputType.number,
                  // controller: myC.cariSurah,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: blackColor!,)
                    ),
                    // labelText: 'sasa',
                    labelStyle: blackTextStyle,
                      fillColor: color,
                      filled: true,
                      hintText: label,
                      hintStyle: TextStyle(color: greyColor),
                      border: OutlineInputBorder(
                          borderSide: border,
                          borderRadius: BorderRadius.circular(10))),
                );
  }
}
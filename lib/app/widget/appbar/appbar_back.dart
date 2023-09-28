import 'package:flutter/material.dart';


AppBar appbarBack({String? title}) {
    return AppBar(
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.black),
      title:  Text( title ?? "Kembali"),
      titleTextStyle: const TextStyle(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }